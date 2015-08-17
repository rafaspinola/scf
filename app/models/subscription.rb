class Subscription < ActiveRecord::Base
  belongs_to :participant
  belongs_to :course_class
  belongs_to :company
  belongs_to :salesman

  has_many :payment_documents

  accepts_nested_attributes_for :participant
  accepts_nested_attributes_for :company

  scope :payment_documents_to_be_generated, -> { includes(:company, :participant, :payment_documents).joins(:payment_documents).where(payment_documents: { generated: false }) }

  before_create do |s|
    s.sequence = get_next_subscription_sequence
    s.payments_quantity = s.course_class.course.get_payments_quantity(s.amount)
  end

  before_save do |s|
    debugger
    s.participant.phone = format_phone(s.participant.phone)
    s.participant.cellphone = format_phone(s.participant.cellphone)
    s.participant.cpf = format_cpf(s.participant.cpf)
    s.participant.postal_code = format_postal_code(s.participant.postal_code)

    s.company.phone = format_phone(s.company.phone)
    s.company.cnpj = format_cnpj(s.company.cnpj)
    s.company.postal_code = format_postal_code(s.company.postal_code)
  end

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

 protected

  def build_bank_payment_documents(s)
    
    for i in 1..s.payments_quantity 
      p = PaymentDocument.create(
        subscription: s,
        document_number: PaymentDocument.generate_billing_number(s.course_class.course.payment_identifier, s.course_class.identifier, s.salesman.identifier, s.sequence, i),
        value: (s.amount / s.payments_quantity),
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

  def clear_number(data)
    data.gsub(/[^\d]/, "")
  end

  def format_phone(data)
    data = clear_number(data)
    m = data.match(/(\d{2})(\d{4,5})(\d{4})/)
    if m == nil
      data
    else
      "(#{m[1]}) #{m[2]}-#{m[3]}"
    end
  end

  def format_postal_code(data)
    data = clear_number(data)
    m = data.match(/(\d{2})(\d{3})(\d{3})/)
    if m == nil
      data
    else
      "#{m[1]}.#{m[2]}-#{m[3]}"
    end
  end

  def format_cpf(data)
    data = clear_number(data)
    m = data.match(/(\d{3})(\d{3})(\d{3})(\d{2})/)
    if m == nil
      data
    else
      "#{m[1]}.#{m[2]}.#{m[3]}-#{m[4]}"
    end
  end

  def format_cnpj(data)
    data = clear_number(data)
    m = data.match(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/)
    if m == nil
      data
    else
      "#{m[1]}.#{m[2]}.#{m[3]}/#{m[4]}-#{m[5]}"
    end
  end
end