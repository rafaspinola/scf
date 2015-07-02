class User < ActiveRecord::Base
  has_one :salesman

  enum role: [:vendedor, :trainer, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :vendedor
  end

  def self.invite_key_fields
    [:email, :name]
  end

  def self.invite_key 
    {:email=>/\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, :name=>/.*/}
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,  :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
