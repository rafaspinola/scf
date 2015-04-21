class Company < ActiveRecord::Base

  def to_s
    self.name
  end

  def document
  	self.cnpj
  end
end
