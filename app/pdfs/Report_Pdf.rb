class ReportPdf<Prawn::Document
  def initialize(report)
    super(top_margin: 70)
    
    @report = report
    text @report.user.name
    text I18n.l(@report.created_at, format: "%a %d.%m.%y").to_s

    move_down 20
    text "Report Content:"
    move_down 20
    text @report.daily_report
    move_down 20
    
    
  end
end