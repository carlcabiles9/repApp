class HomeController < ApplicationController
    def index; 
      @projects = Project.all
      @reports = Report.all
    end
    def daily
      @time = Date.today.to_s(:short)
      @days = User.find(current_user.id).reports.where(user_id: current_user.id, created_at: Date.today.beginning_of_day..Date.today.end_of_day)
      @recipients = Recipient.all
    end
    def send_now
      
    end
    private
    def home_params
      params.require(:home).permit(:weeklyreport, :dailyreport, :monthlyreport)
    end

  

  end
  