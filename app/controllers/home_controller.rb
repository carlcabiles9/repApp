class HomeController < ApplicationController
    def index; 
    
    end
    private
    def home_params
      params.require(:home).permit(:weeklyreport, :dailyreport, :monthlyreport)
    end

  

  end
  