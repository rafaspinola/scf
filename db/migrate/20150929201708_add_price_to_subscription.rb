class AddPriceToSubscription < ActiveRecord::Migration
  def change
    add_reference :subscriptions, :price, index: true
  end
end
