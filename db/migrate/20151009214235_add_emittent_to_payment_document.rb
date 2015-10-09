class AddEmittentToPaymentDocument < ActiveRecord::Migration
  def change
    add_column :payment_documents, :emittent, :string
  end
end
