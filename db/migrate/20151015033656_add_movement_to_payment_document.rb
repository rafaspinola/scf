class AddMovementToPaymentDocument < ActiveRecord::Migration
  def change
    add_reference :payment_documents, :movement, index: true
  end
end
