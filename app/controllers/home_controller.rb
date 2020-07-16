# frozen_string_literal: true

class HomeController < ApplicationController
  add_flash_types :info, :error, :warning

  def send_daily
    reports = Report.all.where(user_id: current_user.id, created_at: Date.today.beginning_of_day..Date.today.end_of_day)
    User.find(current_user.id).recipients.each do |recipient|
      mail_opts = { to: recipient.email }
      UserMailer.daily_report(current_user, reports, mail_opts).deliver_later
    end
    redirect_to(home_index_path, notice: "Email Sent")
  end

  def index
    @users = User.all
    @projects = Project.all
    @reports = Report.all
    @user = User.all
    @project = Project.all
    @report = Report.all
  end

  def daily
    @recipients = Recipient.all
    @users = User.all
    @projects = Project.all
    @reports = Report.all
    @user = User.all
    @project = Project.all
    @report = Report.all
  end

  private

  def home_params
    params.require(:home).permit(:weeklyreport, :dailyreport, :monthlyreport)
  end
end
