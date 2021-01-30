class UserMailer < ActionMailer::Base
 default from: "Ginevar <info@ginevar.com>"

  def welcome_email
    @user = params[:user]
    @url  = 'http://example.com/login'
    mail(to: @user, subject: 'Welcome to My Awesome Site')
  end
  layout 'mailer'
end
