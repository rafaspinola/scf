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

  def valid_for_charging
    err = []
    err << [:name, "A razão social da empresa deve ser informada."] if name.empty? || name == nil
    err << [:cnpj, "O CNPJ da empresa deve ser informado."] if cnpj.empty? || cnpj == nil
    err << [:address, "O endereço da empresa deve ser informado."] if address.empty? || address == nil
    err << [:neighborhood, "O bairro da empresa deve ser informado."] if neighborhood.empty? || neighborhood == nil
    err << [:city, "A cidade da empresa deve ser informada."] if city.empty? || city == nil
    err << [:state, "O estado da empresa deve ser informado."] if state.empty? || state == nil
    err << [:postal_code, "O CEP da empresa deve ser informado."] if postal_code.empty? || postal_code == nil
    err << [:phone, "O telefone da empresa deve ser informado."] if phone.empty? || phone == nil
    err << [:responsible_name, "O nome do responsável pela contratação da empresa deve ser informado."] if responsible_name.empty? || responsible_name == nil
    err << [:responsible_email, "O email do responsável pela contratação da empresa deve ser informado."] if responsible_email.empty? || responsible_email == nil
    err << [:responsible_job_description, "O cargo do responsável pela contratação da empresa deve ser informado."] if responsible_job_description.empty? || responsible_job_description == nil
    err
  end

  protected

  def check_number_lengths
    errors.add(:cnpj, "O CNPJ informado está incorreto.") unless check_number_count(cnpj, 14)
    errors.add(:postal_code, "O CEP informado está incorreto.") unless check_number_count(postal_code, 11)
    errors.add(:phone, "O telefone informado está incorreto.") unless check_number_count(phone, 10, 11)
  end

end
