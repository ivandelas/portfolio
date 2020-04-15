class ProjectsController < ApplicationController
  def index
    @projects = Project.active_projects
  end
end
