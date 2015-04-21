class Account < ActiveRecord::Base
  belongs_to :top_account, class_name: "Account", foreign_key: "top_account_id"

  def to_s
    self.description
  end
end
