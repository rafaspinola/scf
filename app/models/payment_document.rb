# Cheque, boleto
class PaymentDocument < ActiveRecord::Base
  belongs_to :subscription
  has_attached_file :doc_file

  validates_attachment_content_type :doc_file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]

  scope :to_be_generated, -> { where(generated: false) }
  scope :to_be_confirmed, -> { includes(:subscription).where(paid_date: nil).order("subscriptions.payment_method") }

  def self.generate_billing_number(course_payment_identifier, class_identifier, salesmen_identifier, sequence, payment_number)
    sprintf "%s%s%s%02d%d", course_payment_identifier, class_identifier, salesmen_identifier, sequence, payment_number
  end

  def self.update_list(list)
  	list.each do |k, v|
  		pd = PaymentDocument.find k
  		unless pd == nil
  			pd.due_date = Date.parse v[:due_date]
  			pd.value = v[:value]
  			pd.save!
  		end
  	end
  	true
  end
end

