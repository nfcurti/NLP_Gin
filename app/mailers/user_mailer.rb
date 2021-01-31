class UserMailer < ActionMailer::Base
 default from: "Ginevar <info@ginevar.com>"

  def welcome_email
    @user = params[:user]
    @url  = params[:key]
    mail(to: @user, subject: 'Welcome to Ginevar!')
  end
  layout 'mailer'
end
