class ProjectsController < ApplicationController
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
