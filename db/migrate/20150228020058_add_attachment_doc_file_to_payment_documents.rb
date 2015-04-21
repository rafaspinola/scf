class AddAttachmentDocFileToPaymentDocuments < ActiveRecord::Migration
  def self.up
    change_table :payment_documents do |t|
      t.attachment :doc_file
    end
  end

  def self.down
    remove_attachment :payment_documents, :doc_file
  end
end
