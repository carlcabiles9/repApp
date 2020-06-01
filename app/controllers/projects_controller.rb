class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :destroy_project, :search]

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
    @user = User.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @user = User.all
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end
  # GET /resources/search?q={query}
  # GET /resources/search.json?q={query}
  
  def search
     Post.search do
      fulltext 'test' do
        
      end
    end
  end
  

  # POST /projects
  # POST /projects.json
  def create
    @users = User.all
    
    @project = Project.new(project_params)
    # # dapat ma implement to sa ability for now dito muna
    @project.user_id = current_user.id
    # @project.user_id = User.id
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
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
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
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
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_project
    @project.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Project was successfully destroyed.' }
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
      params.require(:project).permit(:name, participant_ids: [])
    end
end

  

