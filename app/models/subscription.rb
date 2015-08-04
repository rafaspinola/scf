class Subscription < ActiveRecord::Base
  belongs_to :participant
  belongs_to :course_class
  belongs_to :company
  belongs_to :salesman

  has_many :payment_documents

  accepts_nested_attributes_for :participant
  accepts_nested_attributes_for :company

  scope :payment_documents_to_be_generated, -> { joins(:payment_documents).where(payment_documents: { generated: false }) }

  before_save do |s|
    s.sequence = get_next_subscription_sequence
    s.payments_quantity = s.course_class.course.get_payments_quantity(s.amount)
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
end