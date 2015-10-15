class AddAttachmentReceiptImageToMovements < ActiveRecord::Migration
  def self.up
    change_table :movements do |t|
      t.attachment :receipt_image
    end
  end

  def self.down
    remove_attachment :movements, :receipt_image
  end
end
