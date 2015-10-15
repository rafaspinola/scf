class AddAttachmentDocumentImageToMovements < ActiveRecord::Migration
  def self.up
    change_table :movements do |t|
      t.attachment :document_image
    end
  end

  def self.down
    remove_attachment :movements, :document_image
  end
end
