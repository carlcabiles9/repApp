# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[show edit update destroy send_daily ]
  require "prawn"
  def download_pdf
    @reports = Report.all
    @projects = Project.all
    @users = User.all.where.not(:id=>current_user.id)
      respond_to do |format|
      format.html
      format.pdf do
        pdf = DownloadPdf.new(@reports,@projects,@users)
        send_data pdf.render, filename: "report.pdf",
                          type: 'application/pdf',
                          disposition: 'inline'
      end
    end
  end

  def user_pdf
    @reports = Report.all.where(created_at: Date.today.beginning_of_week..Date.today.end_of_week)
    @projects = Project.all
    @user = current_user
      respond_to do |format|
      format.html
      format.pdf do
        pdf = UserPdf.new(@reports,@projects,@user)
        send_data pdf.render, filename: "weekly.pdf",
                          type: 'application/pdf',
                          disposition: 'inline'
      end
    end
  end
  # GET /reports
  # GET /reports.json


  def index
    @profiles = Profile.all
    @reports = Report.all
    @users = User.all
    @projects = Project.all
    @search = User.search do
      fulltext params[:search]
    end
    @users = @search.results
  end

  def monthly
    @report = Report.new
    @projects = Project.all
    @report.user_id = current_user.id
  end

  def weekly
    @report = Report.new
    @projects = Project.all
    @report.user_id = current_user.id
  end

  def daily
    @report = Report.new
    @projects = Project.all
    @report.user_id = current_user.id
  end

  def list
    @reports = Report.find :all
  end

  def show_daily
    @projects  = Project.all
    @time = Date.today.to_s(:short)
    @days = Report.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day)
  end

  def show_weekly
    @project = Project.all
    @time = Date.today.beginning_of_week.to_s(:short)
    @end = Date.today.end_of_week.to_s(:short)
    @weeks = Report.where(user_id: current_user.id, created_at: Date.today.beginning_of_week..Date.today.end_of_week)
  end

  def show_monthly
    @project = Project.all
    @time = Date.today.beginning_of_month.to_s
    @end = Date.today.end_of_month.to_s
    @months = Report.where(user_id: current_user.id, created_at: Date.today.beginning_of_month..Date.today.end_of_month)
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @reports = Report.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReportPdf.new(@report)
        send_data pdf.render, filename: "report_#{@report.id}.pdf",
                              type: 'application/pdf',
                              disposition: 'inline'
      end
    end
  end

  # def send_pdf
  #   @user = current_user
  #   @reports = Report.find(params[:id])
  #   pdf = ReportPdf.new(@report)
  #   send_data pdf.render, filename: "report_#{@report.id}.pdf"
  #                         type: 'application/pdf',
  #                         disposition: 'inline'

  # end
  def send_daily
    @report = Report.find(params[:id])
    User.find(current_user.id).recipients.each do |recipient|
      mail_opts = { to: recipient.email }
      reports = ReportPdf.new(@report)
      UserMailer.send_pdf(current_user, reports, mail_opts).deliver_now
    end
  end

  # GET /reports/new
  def new
    @report = Report.new
    @projects = Project.all
  end

  # GET /reports/1/edit
  def edit; end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id
    respond_to do |format|
      if @report.save
        format.html { redirect_to home_index_path, notice: 'Report was successfully created.' }
        format.json { redirect_to home_index_path}
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to home_index_path, notice: 'Report was successfully updated.' }
        format.json { redirect_to home_index_path}
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to home_index_path, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @report = Report.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def report_params
    params.require(:report).permit(:content, :project_id)
  end
end
