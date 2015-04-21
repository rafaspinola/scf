class AddIdentifierToSalesman < ActiveRecord::Migration
  def change
    add_column :salesmen, :identifier, :string
  end
end
