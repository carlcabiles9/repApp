class ReportPdf<Prawn::Document
  def initialize(report)
    super(top_margin: 70)
    
    @report = report
    text @report.user.name
    text I18n.l(@report.created_at, format: "%a %d.%m.%y").to_s

    move_down 20
    text "Project Description:"
    text @report.project.name
    move_down 20
    text "REPORT:"
    text @report.content
    move_down 20
    
    
  end
end