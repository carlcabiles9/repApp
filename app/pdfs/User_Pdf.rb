# frozen_string_literal: true

class UserPdf < Prawn::Document
    def initialize(reports,projects,user)
      super(top_margin: 60, left_margin: 40)
            
            text user.profile.firstname.humanize + " "+ user.profile.lastname.humanize
            text I18n.l(Date.today.beginning_of_week, format: "%a %d/%m/%y") + " to " + I18n.l(Date.today.end_of_week-2.days, format: "%a %d/%m/%y")
            text "Work Done: "
            
            text " "
            user.projects.each do |project|
                text "______________"
                text project.name
                text "______________ "
                project.reports.each do |report|
                    text " "
                    text report.content
                    text " "
                    text "Created at: " + I18n.l(report.created_at, format: "%a %d/%m/%y").to_s
                end
            end

    end
  end
  