class AddPhoneToSalesmen < ActiveRecord::Migration
  def change
    add_column :salesmen, :phone, :string
  end
end
