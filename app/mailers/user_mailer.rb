class UserMailer < ApplicationMailer
  default from: 'cccabiles@cdasia.com'

  def email_report(user, reports, mail_opts)
    @try = User.find(user.id).reports.where(created_at: Date.today.beginning_of_week..Date.today.end_of_week)
    @user = user
    @reports = reports
    @url  = 'http://localhost/3000'
    mail(mail_opts)
  end
end
