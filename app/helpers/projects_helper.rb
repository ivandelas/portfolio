module ProjectsHelper
  def render_projects(projects)
    if projects.any?
      render partial: 'projects/project', collection: projects
    else
      render partial: 'projects/message'
    end
  end
end
