class AddPaymentIdentifierToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :payment_identifier, :string
  end
end
