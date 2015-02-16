class Trainer < ActiveRecord::Base
  has_and_belongs_to_many :course_classes

  def to_s
  	self.name
  end
end
