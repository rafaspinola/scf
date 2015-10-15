# Cheque, boleto
class PaymentDocument < ActiveRecord::Base
  belongs_to :subscription
  belongs_to :bank
  belongs_to :movement
  has_attached_file :doc_file

  validates_attachment_content_type :doc_file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]

  scope :to_be_generated, -> { where(generated: false) }
  scope :to_be_confirmed, -> { includes(:subscription).where(paid_date: nil).where("due_date < ?", Date.today + 7.days).order("subscriptions.payment_method, due_date") }

  def self.generate_billing_number(course_payment_identifier, class_identifier, salesmen_identifier, sequence, payment_number, double_payment_number_digits = false)
    sprintf(get_billing_number_format(double_payment_number_digits), course_payment_identifier, class_identifier, salesmen_identifier, sequence, payment_number)
  end

  def self.get_billing_number_format(double_payment_number_digits)
    double_payment_number_digits ? "%s%s%s%02d%02d" : "%s%s%s%02d%d"

  end

  def self.mark_as_generated_by_subscription(subscription_id)
    ActiveRecord::Base.transaction do
      pd = PaymentDocument.where(subscription_id: subscription_id, generated: false)
      pd.each do |p|
        p.generated = true
        p.save
      end
    end
  end

  def self.update_list(list)
  	ActiveRecord::Base.transaction do
      # TODO: regerar códigos de boletos, quando houver a possibilidade de adicionar novos boletos
	  	total = 0.0
	  	subscription = 0
	  	list.each do |k, v|
	  		pd = PaymentDocument.find k
	  		unless pd == nil
	  			subscription = pd.subscription
	  			pd.due_date = Date.parse v[:due_date]
	  			pd.value = v[:value]
	  			total = total + pd.value
	  			pd.save!
	  		end
	  	end
	  	subscription.amount = total
	  	subscription.save
	  end
	end

  # TODO: os elementos da lista vem tudo como string
  def self.process_paid_list(list)
    to_be_processed = normalize_list(filter_paid(list))
    debugger
    ActiveRecord::Base.transaction do
      documents_to_be_updated = PaymentDocument.where("id in (?)", to_be_processed.keys)
      documents_to_be_updated.each do |d|
        d.payment(to_be_processed[d.id])
      end
    end
  end

  def self.filter_paid(list)
    list.select {|k, v| v["paid"] == "1"}
  end

  def self.normalize_list(list)
    r = {}
    list.each do |k, v|
      r[k.to_i] = v["paid_date"]
    end
    r
  end

  # Must be inside transaction
  def payment(paid_date)
    raise "error" if ActiveRecord::Base.connection.open_transactions == 0
    m = Movement.new(due_date: paid_date,
                        description: "#{self.subscription.payer.name} - #{self.document_number}",
                        value: self.value,
                        course_class_id: self.subscription.course_class_id,
                        account_id: self.subscription.course_class.course.account_id,
                        result_center_id: self.subscription.course_class.result_center_id,
                        bank_id: self.bank_id,
                        accountable: true,
                        credit: true)
    raise "error" unless m.save
    self.paid_date = paid_date
    self.movement_id = m.id
    raise "error" unless self.save
  end

  def paid?
    self.paid_date != nil
  end
end

