class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cnpj
      t.string :county_subscription
      t.string :address
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :phone
      t.string :responsible_name
      t.string :responsible_email
      t.string :responsible_job_description

      t.timestamps
    end
  end
end
