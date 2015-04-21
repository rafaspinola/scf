class CreateResultCenters < ActiveRecord::Migration
  def change
    create_table :result_centers do |t|
      t.string :name

      t.timestamps
    end
  end
end
