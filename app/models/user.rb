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

  # Create User and associated account object
  def self.create_account(account_type, params)
    user = User.create(params)
    case account_type.downcase
      when 'admin'
        account = Admin.create()
      when 'teacher'
        account = Teacher.create()
      when 'student'
        account = Student.create()
      else
        raise ArgumentError, "#{account_type} is not a valid user type"
    end
    account.user = user
    user.account = account
    account.save
    user.save
    account
  end
end
