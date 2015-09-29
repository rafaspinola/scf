class Participant < ActiveRecord::Base
  include ApplicationHelper

  has_many :subscriptions
  accepts_nested_attributes_for :subscriptions

  def to_s
    self.name
  end

  def document
    self.cpf
  end

  before_save do |p|
    p.phone = format_phone(p.phone)
    p.cellphone = format_phone(p.cellphone)
    p.cpf = format_cpf(p.cpf)
    p.postal_code = format_postal_code(p.postal_code)
  end

end
