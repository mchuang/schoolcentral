class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # from => User
  # to => User
  # subject => str
  # message => str
  def custom_email(from, to, subject, message)
    @message = message
    mail(to: to.email,
         from: from.email,
         subject: subject)
  end
end
