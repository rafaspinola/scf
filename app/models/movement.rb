class Movement < ActiveRecord::Base
  belongs_to :course_class
  belongs_to :account
  belongs_to :result_center
  belongs_to :bank
  belongs_to :to_bank, class_name: "Bank", foreign_key: "to_bank_id"

  scope :recent, -> { where("due_date >= ?", Date.today - 3.days) }

  validates_presence_of :due_date, :description, :value, :account, :result_center, :bank
  validates_numericality_of :value, message: "O valor precisa ser um número"

end
