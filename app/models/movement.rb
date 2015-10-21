class Movement < ActiveRecord::Base
  belongs_to :course_class
  belongs_to :account
  belongs_to :result_center
  belongs_to :bank
  belongs_to :to_bank, class_name: "Bank", foreign_key: "to_bank_id"
  has_one :payment_document
  has_one :transfer_movement, class_name: "Movement", foreign_key: "transfer_movement_id"
  has_many :materials
  has_attached_file :document_image
  has_attached_file :receipt_image

  scope :recent, -> { where("due_date >= ?", Date.today - 3.days) }
  scope :materialsa, -> { joins(:bank).where("material = 1").order("due_date DESC") }

  validates_presence_of :due_date, :description, :value, :account, :result_center, :bank
  validates_numericality_of :value, message: "O valor precisa ser um número"
  validates_attachment_content_type :document_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]
  validates_attachment_content_type :receipt_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif", "application/pdf"]

  before_create :create_transfer_movement
  
  def to_s
    "#{self.due_date.strftime('%d/%m/%Y')} - #{self.description} - #{self.value}"
  end

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
