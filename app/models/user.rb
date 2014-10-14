class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable, :stretches => 12

  # Belongs to Teachers/Students/Admins (as account)
  belongs_to :account, :polymorphic => true

  # Virtual attribute to login with either email or identifier
  attr_accessor :login

  # Overwrite default validations
  def email_required?
    false
  end

  def email_changed?
    false
  end

  # Overwrite to allow find_by identifier OR email in the same field
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["identifier = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions).first
    end
  end
end
