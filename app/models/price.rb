class Price < ActiveRecord::Base
  belongs_to :course
  has_many :subscriptions

  before_destroy :check_subscriptions
  before_update :check_subscriptions

  def total_value
  	self.payment_quantity * self.payment_value
  end

  protected

  def check_subscriptions
  	if subscriptions.count > 0
  		errors.add_to_base("não pode editar ou apagar tabela de preço associada a uma inscrição")
  		return false
  	end
  end
end
