class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def custom_email(params)
    @message = params[:message]
    mail(params.except(:message))
  end
end
