# frozen_string_literal: true

class ReportPdf < Prawn::Document
  def initialize(report)
    super(top_margin: 60)

    @report = report
    text User.find(@report.user_id).name.humanize
    text I18n.l(@report.created_at, format: '%a %d.%m.%y').to_s
    move_down 20
    text 'Report Content:'
    move_down 20
    text @report.content
    move_down 200
    text "DISCLAIMER. This transmission is intended to be delivered only to the named addressee(s) and may contain information that is confidential, proprietary or privileged. If this information is received by anyone other than the named addressee(s), the recipient should immediately notify the sender by e-mail and by telephone and obtain instructions as to the disposal of the transmitted material. In no event shall this material be read, used, copied, reproduced, stored or retained by anyone other than the named addressee(s), except with the express consent of the sender or the named addressee(s). If you are not the intended recipient, you are hereby notified that any use, dissemination, distribution, copying or storage of this message or any attachment is strictly prohibited. Thank you."
  end
end
