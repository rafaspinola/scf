class Account < ActiveRecord::Base
  belongs_to :top_account, class_name: "Account", foreign_key: "top_account_id"
  has_many :child_accounts, class_name: "Account", foreign_key: "top_account_id"

  def to_s
    self.description
  end

  def self.ordered_list
    root = root_accounts
    tree = []
    root.each do |r|
      tree << r
      tree << r.child_accounts
    end
    tree.flatten
  end

  def self.root_accounts
    self.where top_account: nil
  end

end
