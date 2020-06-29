# frozen_string_literal: true

class HomeController < ApplicationController
  add_flash_types :info, :error, :warning

  def index
    @projects = Project.all
    @reports = Report.all
  end

  def daily
    @time = Date.today.to_s(:short)
    @days = User.find(current_user.id).reports.where(user_id: current_user.id,
                                                     created_at: Date.today.beginning_of_day..Date.today.end_of_day)
    @recipients = Recipient.all
  end

  def send_now
    User.find(current_user.id).recipients.each do |recipient|
      mail_opts = { to: recipient.email }
      report = current_user.reports.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day)
      DailyMailer.email_report(current_user, report, mail_opts).deliver_later
    end
    redirect_to(home_index_path, notice: 'Email Sent')
    flash[:notice]
  end

    private

  def home_params
    params.require(:home).permit(:weeklyreport, :dailyreport, :monthlyreport)
  end
  end
