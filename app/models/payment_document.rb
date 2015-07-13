# Cheque, boleto
class PaymentDocument < ActiveRecord::Base
  belongs_to :subscription
  has_attached_file :doc_file

  validates_attachment_content_type :doc_file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]

  scope :to_be_generated, -> { where(generated: false) }
  scope :to_be_confirmed, -> { includes(:subscription).where(paid_date: nil).order("subscriptions.payment_method") }

  def self.generate_billing_number(class_identifier, salesmen_identifier, sequence, payment_number)
    sprintf "%s%s%02d%d", class_identifier, salesmen_identifier, sequence, payment_number
  end
end

