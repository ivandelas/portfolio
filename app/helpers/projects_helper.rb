module ProjectsHelper
  def render_no_projects_message
    if owner_logged_in?
      return %{
        You don't have any projects yet!
        #{link_to 'Add one now!', new_project_path}
      }.html_safe
    end

    %{
      It seems like the owner of this portfolio hasn't added any project yet...
    }.html_safe
  end

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
