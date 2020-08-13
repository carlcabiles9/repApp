# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'cabilesc.alvin@gmail.com'

  def email_report(user,project, reports, recipient)
    @user = user
    @reports = reports
    @url = 'http://localhost/3000'
    mail(
      :subject => 'Daily Report',
      :to  => @recipient.email ,
      :from => 'cabilesc.alvin@gmail.com',
    )
  end

  def daily_report(user,project, reports, recipient)
    @user = user
    @project = project
    @reports = reports
    @recipient = recipient
    @url = 'http://localhost/3000'
    attachments['weekly.pdf'] = Prawn::Document.new() do |doc|
       user.profile.firstname.humanize + " "+ user.profile.lastname.humanize
             I18n.l(Date.today.beginning_of_week, format: "%a %d/%m/%y") + " to " + I18n.l(Date.today.end_of_week-2.days, format: "%a %d/%m/%y")
             "Work Done: "
            
             " "
            user.projects.each do |project|
                 "______________"
                 project.name
                 "______________ "
                project.reports.each do |report|
                     " "
                     report.content
                     " "
                     "Created at: " + I18n.l(report.created_at, format: "%a %d/%m/%y").to_s
                end
            end
    end.render

    mail(
  :subject => 'Daily Report',
  :to  => @recipient.email ,
  :from => 'cabilesc.alvin@gmail.com',
)
  end

  def send_pdf(user, reports, mail_opts)
    attachments['report_form.pdf'] = ReportPdf.new(@report_id).render
    mail(mail_opts, subject: 'PDF Attachment of report')
  end

  def send_new_user_message(user)
    @user = User.find(user.id)
    @url = 'http://localhost/3000'
    mail(to: user.email, subject: "CD ASIA REPORT GENERATOR")
  end

  def project_request(user, project, admin)
    @user = user
    @project = project
    mail(to: admin, subject: "Request to join project")
  end


end
