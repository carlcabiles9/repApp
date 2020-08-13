# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :run
  
  def show_report
    @project = Project.find(params[:id])
    @reports = Report.all
  end


  def send_request
    @project = Project.find(params[:id])
    User.find((User.with_role :admin).ids).each do |rs|
      UserMailer.project_request(current_user,@project, rs.email).deliver_now
    end
  end

  def send_daily
    current_user.projects.each do |project|
      project.recipients.each do |recipient|
        mail_opts = {to: Recipient.find(recipient.id).email}
        project.reports.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day).each do |report|
        if report.present?
            UserMailer.daily_report(current_user,project,report,recipient).deliver_now
        else
        
        end
        end
      end
    end
  end

    # if User.find(current_user.id).recipients.nil?
    #   flash[notice: "No registered recipients"]
    # else
    #   reports = Report.all.where(user_id: current_user.id, created_at: Date.today.beginning_of_day.to_s..Date.today.end_of_day.to_s, rep_type: "daily")
    #   User.find(current_user.id).recipients.each do |recipient|
    #     mail_opts = { to: recipient.email }
    #     UserMailer.daily_report(current_user, reports, mail_opts).deliver_now
    #   end
    #     redirect_to(home_index_path, notice: "Email Sent")
    # end
  


  def run
    if user_signed_in?
      
        if Date.today.monday?
          reports = Report.all.where(user_id: current_user.id, created_at: Date.today.beginning_of_week.to_s..Date.today.end_of_week.to_s, rep_type: "weekly")
          # User.find(current_user.id).recipients.each do |recipient|
            # mail_opts = { to: recipient.email }
            # UserMailer.email_report(current_user, reports, mail_opts).deliver_now
          # end
        end
    end
  end
  def index
    @users = User.all
    @projects = Project.all
    @reports = Report.all
    @user = User.all
    @project = Project.all
    @report = Report.new
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
