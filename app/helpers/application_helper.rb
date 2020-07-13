module ApplicationHelper
  def render_loading_dimmer
    if ['projects', 'owner'].include?(controller.controller_name)
      if ['new', 'edit'].include?(controller.action_name)
        return %{
          <div id="all-window">
            <div class="ui dimmer">
              <div class="ui indeterminate text loader">Processing the data provided</div>
            </div>
          </div>
          #{javascript_pack_tag 'loader'}
        }.html_safe
      end
    end

    nil
  end

  def render_if_owner_logged(partial)
    return render partial: partial, locals: { logged: owner_logged_in? }
  end

  def render_if_owner_not_logged(partial)
    unless owner_logged_in?
      return render partial: partial
    end

    nil
  end

  def render_nav_links
    if controller.controller_name == 'owner'
      return [
        link_to('Preview', root_path, class: 'item audacious active'),
        link_to('Edit Profile', edit_owner_path, class: 'item audacious'),
        %{
          <div class="ui dropdown item">
            <span class="audacious">Projects</span>
            <i class="dropdown icon"></i>
            <div class="menu">
              #{link_to 'Listing', projects_path, class: 'item'}
              #{link_to 'Create', new_project_path, class: 'item'}
            </div>
          </div>
        },
        link_to('Logout', logout_path, method: :delete, class: 'item')
      ].join('').html_safe
    elsif controller.controller_name == 'mastermind'
      return [
        link_to('Preview', root_path, class: 'item audacious active'),
        link_to('Edit Profile', edit_owner_path, class: 'item audacious'),
        %{
          <div class="ui dropdown item">
            <span class="audacious">Projects</span>
            <i class="dropdown icon"></i>
            <div class="menu">
              #{link_to 'Listing', projects_path, class: 'item'}
              #{link_to 'Create', new_project_path, class: 'item'}
            </div>
          </div>
        },
        link_to('Logout', logout_path, method: :delete, class: 'item')
      ].join('').html_safe
    else
      if controller.action_name == 'new'
        return [
          link_to('Preview', root_path, class: 'item audacious'),
          link_to('Edit Profile', edit_owner_path, class: 'item audacious'),
          %{
            <div class="ui dropdown item">
              <span class="audacious">Projects</span>
              <i class="dropdown icon"></i>
              <div class="menu">
                #{link_to 'Listing', projects_path, class: 'item'}
                #{link_to 'Create', new_project_path, class: 'active item'}
              </div>
            </div>
          },
          link_to('Logout', logout_path, method: :delete, class: 'item')
        ].join('').html_safe
      else
        return [
          link_to('Preview', root_path, class: 'item audacious'),
          link_to('Edit Profile', edit_owner_path, class: 'item audacious'),
          %{
            <div class="ui dropdown item">
              <span class="audacious">Projects</span>
              <i class="dropdown icon"></i>
              <div class="menu">
                #{link_to 'Listing', projects_path, class: 'active item'}
                #{link_to 'Create', new_project_path, class: 'item'}
              </div>
            </div>
          },
          link_to('Logout', logout_path, method: :delete, class: 'item')
        ].join('').html_safe
      end
    end
  end
end
