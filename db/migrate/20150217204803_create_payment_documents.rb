class CreatePaymentDocuments < ActiveRecord::Migration
  def change
    create_table :payment_documents do |t|
      t.references :subscription, index: true
      t.decimal :value, precision: 10, scale: 2
      t.string :document_number
      t.string :bank
      t.string :agency
      t.string :account
      t.date :due_date
      t.date :paid_date

      t.timestamps
    end
  end
end
