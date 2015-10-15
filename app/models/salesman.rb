class Salesman < ActiveRecord::Base
  belongs_to :user

  def to_s
    self.name
  end
end
