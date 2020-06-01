class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  

  # GET /reports
  # GET /reports.json
  def index
    @report = Report.all
    @user = User.all
    @project = Project.all
  end
  def list
    @reports = Report.find :all
  end

  def send_report
    params[:to].each do |receipient|
      mail_opts = { to: User.find_by(email: receipient).email, subject: params[:subject] }
      reports = current_user.reports.where("created_at > ?", Date.today.beginning_of_day)
      UserMailer.email_report(current_user, reports, mail_opts)
    end
  end
  # def daily
  # end
  
  # def weekly
  # end
  
  # def monthly
  #   @report.all.group_by{ |u| u.created_at.beginning_of_month }
  # end


  # GET /reports/1
  # GET /reports/1.json
  def show
  
    @reports = Report.find(params[:id])
    respond_to do |format|
    format.html
    format.pdf do
      pdf = ReportPdf.new(@report)
      send_data pdf.render, filename: "report_#{@report.name}.pdf",
                            type: "application/pdf",
                            disposition: "inline"
      end
    end
  end

  # GET /reports/new
  def new
    @report = Report.new
    @project = Project.all
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports
  # POST /reports.json
  def create
    @users = User.all
    @project = Project.all
    @report = Report.new(report_params)
    @report.user_id = current_user.id
   
    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
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
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
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
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
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
      params.require(:report).permit(:user_id, :project_id, :content)
    end
end
