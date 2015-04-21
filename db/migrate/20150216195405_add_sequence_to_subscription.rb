class AddSequenceToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :sequence, :integer
  end
end
