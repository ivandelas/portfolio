module ProjectsHelper
  def render_projects(projects)
    if projects.any?
      render partial: 'projects/project', collection: projects
    else
      render partial: 'projects/message'
    end
  end

  def render_column_wrapper(columns, start=true)
    if columns
      if start
        '<div class="column">'.html_safe
      else
        '</div>'.html_safe
      end
    end
  end
end
