class Company < ActiveRecord::Base
  include ApplicationHelper

  def to_s
    self.name
  end

  def document
  	self.cnpj
  end

	before_save do |c|
    c.phone = format_phone(c.phone)
    c.cnpj = format_cnpj(c.cnpj)
    c.postal_code = format_postal_code(c.postal_code)
  end

end
