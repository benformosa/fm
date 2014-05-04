class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :rememberable

  def get_ldap_email
    email = Devise::LDAP::Adapter.get_ldap_param(self.login, 'mail')
    unless email.nil?
      self.email = email.first
    end
  end

  def get_ldap_name
    name = Devise::LDAP::Adapter.get_ldap_param(self.login, 'name')
    unless name.nil?
      self.name = name.first
    else
      self.name = self.login
    end
  end

  before_save :get_ldap_email
  before_save :get_ldap_name

  has_many :trips
  has_many :cars, through: :trips
  
  validates :login, presence: true,
    uniqueness: true
end
