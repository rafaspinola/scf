class AddKindToPaymentDocument < ActiveRecord::Migration
  def change
    add_column :payment_documents, :kind, :string
  end
end
