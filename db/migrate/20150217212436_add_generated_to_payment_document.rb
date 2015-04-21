class AddGeneratedToPaymentDocument < ActiveRecord::Migration
  def change
    add_column :payment_documents, :generated, :boolean
  end
end
