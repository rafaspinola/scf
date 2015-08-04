class Movement < ActiveRecord::Base
  belongs_to :course_class
  belongs_to :account
  belongs_to :result_center
  belongs_to :bank
  belongs_to :to_bank, class_name: "Bank", foreign_key: "to_bank_id"
  has_one :transfer_movement, class_name: "Movement", foreign_key: "transfer_movement_id"

  scope :recent, -> { where("due_date >= ?", Date.today - 3.days) }

  validates_presence_of :due_date, :description, :value, :account, :result_center, :bank
  validates_numericality_of :value, message: "O valor precisa ser um número"

  before_create :create_transfer_movement
  

  def create_transfer_movement
  	if self.transfer then
  		self.transfer_movement = self.dup
  		self.transfer_movement.bank_id = self.transfer_movement.to_bank_id
  		self.transfer_movement.to_bank_id = nil
  		self.transfer_movement.credit = !self.transfer_movement.credit
  	end
    true
  end
end
