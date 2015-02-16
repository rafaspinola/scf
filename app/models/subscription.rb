class Subscription < ActiveRecord::Base
  belongs_to :participant
  belongs_to :course_class
  belongs_to :company
  belongs_to :salesman

  accepts_nested_attributes_for :participant
  accepts_nested_attributes_for :company
end
