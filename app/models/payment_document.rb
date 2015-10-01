# Cheque, boleto
class PaymentDocument < ActiveRecord::Base
  belongs_to :subscription
  has_attached_file :doc_file

  validates_attachment_content_type :doc_file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]

  scope :to_be_generated, -> { where(generated: false) }
  scope :to_be_confirmed, -> { includes(:subscription).where(paid_date: nil).order("subscriptions.payment_method") }

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
end

