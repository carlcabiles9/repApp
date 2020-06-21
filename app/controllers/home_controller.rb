class HomeController < ApplicationController
    def index; 
    
    end
    def weekly
     
    end
    def daily

    end
    def monthly

    end
    private
    def home_params
      params.require(:home).permit(:weeklyreport, :dailyreport, :monthlyreport)
    end

  

  end
  