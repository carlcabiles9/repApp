# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'cccabiles@cdasia.com'

  def email_report(user, reports, mail_opts)
    @user = user
    @reports = reports
    @url = 'http://localhost/3000'
    mail(mail_opts)
  end

  def daily_report(user, reports, mail_opts)
    @user = user
    @reports = reports
    @url = 'http://localhost/3000'
    mail(mail_opts, subject: "Daily Report")
  end

  def send_pdf(user, reports, mail_opts)
    attachments['report_form.pdf'] = ReportPdf.new(@report_id).render
    mail(mail_opts, subject: 'PDF Attachment of report')
  end
end
