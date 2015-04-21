class Participant < ActiveRecord::Base
  has_many :subscriptions
  accepts_nested_attributes_for :subscriptions

  def to_s
    self.name
  end

  def document
    self.cpf
  end

end
