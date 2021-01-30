class ApplicationMailer < ActionMailer::Base
  default from: 'info@ginevar.com'

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
  layout 'mailer'
end
