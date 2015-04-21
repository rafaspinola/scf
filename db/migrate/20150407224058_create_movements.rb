class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.date :due_date
      t.string :description
      t.decimal :value
      t.references :course_class, index: true
      t.references :account, index: true
      t.references :result_center, index: true
      t.references :bank, index: true

      t.timestamps
    end
  end
end
