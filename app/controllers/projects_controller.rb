# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy destroy_project search]
  before_action :authorize_admin
  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    @users = User.all
    @search = Project.search do
      fulltext params[:search]
    end
    @projects = @search.results
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @user = User.all
  end

  # GET /projects/new
  def new
    @project = Project.new
    @recipient = Recipient.new
    @recipients = Recipient.all
    
  end

  # GET /projects/1/edit
  def edit
  end
  # GET /resources/search?q={query}
  # GET /resources/search.json?q={query}

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    respond_to do |format|
      if @project.save
        format.html { redirect_to home_index_path, notice: 'Project was successfully created.' }
        format.json { redirect_to projects_path }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

 
  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_path ,notice: 'Project was successfully updated.' }
        format.json { redirect_to projects_path }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to home_index_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_project
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :status, participant_ids: [], recipient_ids: [])
  end
end
