class ExportPdf<Prawn::Document
  def initialize(report)
    super(top_margin: 70)
    @report = report
    
    move_down 20
    text "Project Description:"
    text @report.project.name
    move_down 20
    text "REPORT:"
    text @report.content
      
    
  end
end