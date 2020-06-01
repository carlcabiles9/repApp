class HomeController < ApplicationController
    def index; 
     @users = User.all
     @reports = Report.all
     @project = Project.all
    end
  end
  