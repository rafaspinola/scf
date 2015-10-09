class Bank < ActiveRecord::Base

	scope :financial, -> { where("financial = 1").order("main DESC, name") }

  def to_s
    return self.name
  end
end
