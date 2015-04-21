class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :description
      t.references :top_account, index: true

      t.timestamps
    end
  end
end
