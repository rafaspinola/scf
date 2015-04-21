class AddPaymentsQuantityToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :payments_quantity, :integer
  end
end
