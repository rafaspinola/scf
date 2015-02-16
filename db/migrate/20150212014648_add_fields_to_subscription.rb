class AddFieldsToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :retains_iss, :boolean
    add_column :subscriptions, :charge_company, :boolean
    add_column :subscriptions, :first_payment_date, :date
    add_column :subscriptions, :observations, :text
    add_column :subscriptions, :payment_method, :string
  end
end
