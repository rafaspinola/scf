class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :participant, index: true
      t.references :course_class, index: true
      t.references :company, index: true
      t.references :salesman, index: true
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
