class UserMailer < ApplicationMailer
  default from: 'cccabiles@cdasia.com'

  def email_report(user, reports, mail_opts)
    @user = user
    @reports = reports
    @url  = 'http://localhost/3000'
    mail(mail_opts)
  end
end
