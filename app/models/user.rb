# @author: elewis, jdefond

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable, :stretches => 12

  belongs_to :school

  # Belongs to Teachers/Students/Admins (as account)
  belongs_to :account, :polymorphic => true

  validates :identifier, presence: { unless: :email_present? }
  validates :email,      presence: { unless: :identifier_present? }

  validates :identifier, uniqueness: { allow_blank: true, allow_nil: true }
  validates :email,      uniqueness: { allow_blank: true, allow_nil: true }

  # Virtual attribute to login with either email or identifier
  attr_accessor :login

  def identifier_present?
    !(identifier.nil? || identifier.blank?)
  end

  def email_present?
    !(email.nil? || email.blank?)
  end

  # Overwrite default validations
  def email_required?
    false
  end

  def email_changed?
    false
  end

  # Overwrite to allow find_by identifier OR email in the same field
  # login is scoped by school, given the school identifier string
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    school = School.find_by_identifier(conditions.delete(:school_id))
    login = conditions.delete(:login)
    scope = where(conditions)\
      .where("identifier = :value OR lower(email) = lower(:value)", { value: login })\
      .where("school_id = ?", school.nil? ? nil : school.id)\
      .first
  end

  # Create User and associated account object
  def self.create_account(account_type, params)
    case account_type.downcase
      when 'admin'
        params[:account] = Admin.create()
      when 'teacher'
        params[:account] = Teacher.create()
      when 'student'
        params[:account] = Student.create()
      else
        raise ArgumentError, "#{account_type} is not a valid user type"
    end
    User.create(params).account
  end

  # Create User and associated account with a random password. The
  # generated password is returned along with the account.
  #
  # IF THE PASSWORD IS LOST AFTER THIS CALL IT CANNOT BE RECOVERED
  def self.create_account_random_pass(account_type, params)
    pass = random_password(10)
    params[:password] = params[:password_confirmation] = pass
    return create_account(account_type, params), pass
  end

  # Send an email message to given recipients
  def send_email(params)
    params[:from] ||= email
    UserMailer.custom_email(params).deliver
  end

  # Send an email message to multiple, separate recipients (using bcc)
  def blast_email(params)
    # Accumulates all addresses from :to, :cc, and :bcc fields into one array
    recipients = [:to, :cc, :bcc].map {|f| params.fetch(f, [])}.flatten + [email]
    mail_params = {
      from:    params.fetch(:from, email),
      bcc:     recipients.uniq,
      subject: params[:subject], # Required
      message: params[:message], # Required
    }
    UserMailer.custom_email(mail_params).deliver
  end

  private

  # Generates a random string of printable characters with given length
  def self.random_password(len)
    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!?@#$%&*'
    (0...len).map { alphabet[SecureRandom.random_number(alphabet.length)] }.join
  end
end
