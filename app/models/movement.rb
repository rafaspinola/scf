class Movement < ActiveRecord::Base
  belongs_to :course_class
  belongs_to :account
  belongs_to :result_center
  belongs_to :bank
  belongs_to :to_account, class_name: "Account", foreign_key: "to_account_id"
end
