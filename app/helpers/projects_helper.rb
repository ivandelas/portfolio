module ProjectsHelper
  def render_projects(projects)
    if projects.any?
      render partial: 'projects/project', collection: projects
    else
      render partial: 'projects/message'
    end
  end

  def render_buttons(controller, action, project)
    if action == 'index' && controller == 'projects'
      render partial: 'projects/buttons', locals: { project: project }
    end
  end
end
