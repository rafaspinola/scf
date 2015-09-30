class Participant < ActiveRecord::Base
  include ApplicationHelper

  has_many :subscriptions
  accepts_nested_attributes_for :subscriptions

  validates_presence_of :name, :cellphone, :email, :birthday, :marital_state, message: "Campo obrigatório para o recebimento da inscrição."
  validate :check_number_lengths

  def to_s
    self.name
  end

  def document
    self.cpf
  end

  def valid_for_charging
    err = []
    err << [:cpf, "O CPF do participante deve ser informado."] if cpf.empty? || cpf == nil
    err << [:address, "O endereço do participante deve ser informado."] if address.empty? || address == nil
    err << [:neighborhood, "O bairro do participante deve ser informado."] if neighborhood.empty? || neighborhood == nil
    err << [:city, "A cidade do participante deve ser informada."] if city.empty? || city == nil
    err << [:state, "O estado do participante deve ser informado."] if state.empty? || state == nil
    err << [:postal_code, "O CEP do participante deve ser informado."] if postal_code.empty? || postal_code == nil
    err << [:phone, "O telefone fixo do participante deve ser informado."] if phone.empty? || phone == nil
    err << [:profession, "A profissão do participante deve ser informada."] if profession.empty? || profession == nil
    err << [:job_description, "A função do participante deve ser informada."] if job_description.empty? || job_description == nil
    err
  end

  before_save do |p|
    p.phone = format_phone(p.phone)
    p.cellphone = format_phone(p.cellphone)
    p.cpf = format_cpf(p.cpf)
    p.postal_code = format_postal_code(p.postal_code)
  end

  protected

  def check_number_lengths
    errors.add(:cpf, "O CPF informado está incorreto.") unless check_number_count(cpf, 11)
    errors.add(:postal_code, "O CEP informado está incorreto.") unless check_number_count(postal_code, 11)
    errors.add(:phone, "O telefone informado está incorreto.") unless check_number_count(phone, 10, 11)
    errors.add(:cellphone, "O telefone celular informado está incorreto.") unless check_number_count(cellphone, 10, 11)
  end

end
