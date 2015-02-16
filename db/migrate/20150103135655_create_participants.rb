class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :name
      t.string :cpf
      t.date :birthday
      t.string :marital_state
      t.string :address
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :phone
      t.string :cellphone
      t.string :email
      t.string :profession
      t.string :job_description

      t.timestamps
    end
  end
end
