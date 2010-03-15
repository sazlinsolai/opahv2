class User < ActiveRecord::Base
  
  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles
  #TODO when already define profile model
  #has_one :profile
  belongs_to :account

  attr_accessible :login, :email, :password, :password_confirmation
  
  acts_as_authentic do |c|
    c.validations_scope = :account_id
  end

end
