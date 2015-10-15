class Subscription < ActiveRecord::Base
  belongs_to :participant
  belongs_to :course_class
  belongs_to :company
  belongs_to :salesman
  belongs_to :price

  has_many :payment_documents

  accepts_nested_attributes_for :participant
  accepts_nested_attributes_for :company

  scope :payment_documents_to_be_generated, -> { includes(:company, :participant, :payment_documents).joins(:payment_documents).where(payment_documents: { generated: false }) }

  validates_presence_of :salesman, message: "Selecione o vendedor"
  validates_presence_of :course_class, message: "Selecione a turma a qual se refere essa inscrição"
  validates_presence_of :payment_method
  validates_inclusion_of :charge_company, :in => [true, false], message: "Informe para quem será feita a cobrança / emitidos os boletos"
  validates_inclusion_of :retains_iss, :in => [true, false], message: "SOMENTE PARA EMPRESAS COM SEDE EM BELO HORIZONTE: Informe se a empresa retém ISS ou não."
  validates_associated :participant, :company
  validate :check_pf_pj_info
  validate :check_first_payment_date # create

  after_validation :clear_empty_company
  before_create :fill_sequence, :fill_price

  # TODO: validador:
  # Não permitir data do primeiro pagamento após o início da turma
  # Exigir dados PF/PJ de acordo com a forma de pagamento escolhida

  after_create do |s|
    build_bank_payment_documents(s) if s.payment_method == "B"
  end

  def payer
    self.charge_company ? self.company : self.participant
  end

  def payment_method_requires_payment_document_generation?
    self.payment_method == "B"
  end

  def payment_method_requires_payment_document_input?
    self.payment_method == "C"
  end

  def has_observations?
    (!self.observations != nil && !self.observations.empty?)
  end

  def has_generated_payment_documents?
    has = false
    self.payment_documents.each do |p|
      has = has || p.generated
    end
    has
  end

  def first_training_date
    return (Date.today - 100.years) if course_class == nil || course_class.course_class_dates == nil
    course_class.course_class_dates.order("day ASC").first.day
  end

 protected

  def build_bank_payment_documents(s)
    for i in 1..s.payments_quantity 
      p = PaymentDocument.create(
        subscription: s,
        document_number: PaymentDocument.generate_billing_number(s.course_class.course.payment_identifier, s.course_class.identifier, s.salesman.identifier, s.sequence, i, payments_quantity > 9),
        value: s.price.payment_value,
        due_date: s.first_payment_date + (i - 1).month,
        generated: false,
        kind: "B")
    end
  end

  def get_next_subscription_sequence
    last_subscription = get_last_subscription
  	if last_subscription == nil then
  		1
  	else
  		last_subscription.sequence + 1
  	end
  end

  def get_last_subscription
  	Subscription.where(course_class_id: self.course_class.id).order(:sequence).last
  end

  def fill_sequence
    self.sequence = get_next_subscription_sequence
  end

  def fill_price
    price = Price.find price_id
    self.payments_quantity = price.payment_quantity
    self.amount = price.total_value
  end

  def clear_empty_company
    self.company = nil if self.company == nil || self.company.empty?
  end

  def check_pf_pj_info
    if charge_company then
      add_entity_errors(company, company.valid_for_charging)
    else
      add_entity_errors(participant, participant.valid_for_charging)
    end
  end

  def add_entity_errors(entity, err)
    err.each do |e|
      entity.errors.add(e[0], e[1])
    end
  end

  def check_first_payment_date
    errors.add(:first_payment_date, "O primeiro pagamento não pode ser posterior ao início da turma.") if new_record? && (first_payment_date > first_training_date)
  end
end