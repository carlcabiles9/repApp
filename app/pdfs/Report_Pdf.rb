# frozen_string_literal: true

class ReportPdf < Prawn::Document
  def initialize(report)
    super(top_margin: 60, left_margin: 40)
    
    @report = report
    text User.find(@report.user_id).name.humanize
    move_down 20
    text I18n.l(@report.created_at, format: "%a %d/%m/%y").to_s
    move_down 60
    text 'Weekly Report Content:'
    move_down 20
    text @report.content
    move_down 350
    
        
  end
end
