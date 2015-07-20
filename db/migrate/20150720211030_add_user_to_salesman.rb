class AddUserToSalesman < ActiveRecord::Migration
  def change
    add_reference :salesmen, :user, index: true
  end
end
