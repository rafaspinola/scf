class AddDepositBankToPaymentDocument < ActiveRecord::Migration
  def change
    rename_column :payment_documents, :bank, :origin_bank
    add_reference :payment_documents, :bank, index: true
  end
end
