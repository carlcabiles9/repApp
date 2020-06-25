# frozen_string_literal: true

class DailyMailer < ApplicationMailer
  default from: 'cccabiles@cdasia.com'

  def email_report(user, report, mail_opts)
    @user = user
    @report = report
    @url = 'http://localhost/3000'
    mail(mail_opts, subject: 'Daily Report')
  end
end
