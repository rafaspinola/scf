class AddPhoneToTrainer < ActiveRecord::Migration
  def change
    add_column :trainers, :phone, :string
  end
end
