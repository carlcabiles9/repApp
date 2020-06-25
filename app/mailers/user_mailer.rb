# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'cccabiles@cdasia.com'

  def email_report(user, _reports, mail_opts)
    @try = User.find(user.id).reports.where(created_at: Date.today.beginning_of_week..Date.today.end_of_week)
    @user = user
    @report = report
    @url = 'http://localhost/3000'
    mail(mail_opts, subject: 'Daily Report')
  end
end
