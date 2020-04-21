class ProjectsController < ApplicationController
  before_action :ensure_owner_logged_in

  def toggle_active
    @project = Project.find(params[:id])
    msg = @project.active? ? 'Project deactivated' : 'Project activated'
    @project.toggle!(:active)
    flash.now[:info] = msg
    respond_to :js
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash.now[:success] = 'Project deleted'
    respond_to :js
  end

  def update
    @project = Project.find(params[:id])

    if @project.update(project_params)
      if project_params[:demo_image]
        @project.demo_image.purge
        @project.demo_image.attach(project_params[:demo_image])
      end

      flash[:success] = 'Project updated'
      redirect_to projects_url
    else
      render :edit
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def index
    @projects = Owner.first.projects
  end

  def new
    @project = Project.new
  end

  def create
    @project = Owner.first.projects.build(project_params)

    if @project.save
      @project.demo_image.attach(project_params[:demo_image])

      unless @project.demo_image.attached?
        @project.demo_image.attach(
          io: File.open(Rails.root.join(
            'app', 'assets', 'images', 'placeholder.jpg')),

           filename: 'placeholder.jpg',
           content_type: 'image/jpeg'
        )
      end

      flash[:success] = 'Project created!'
      redirect_to projects_url
    else
      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(
      :title, :description, :demo_image, :repo, :site
    )
  end
end
