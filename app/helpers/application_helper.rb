module ApplicationHelper
  def render_nav_links
    if controller.controller_name == 'owner'
      return link_to('Preview', root_path, class: 'item audacious'),
        link_to('Edit Profile', edit_owner_path,
                class: 'item audacious active'),
        %{
        <div class="ui dropdown item">
          <span class="audacious">Projects</span>
          <i class="dropdown icon"></i>
          <div class="menu">
            #{link_to 'Listing', projects_path, class: 'item'}
            #{link_to 'Create', new_project_path, class: 'item'}
          </div>
        </div>
      }.html_safe
    elsif controller.controller_name == 'mastermind'
      return link_to('Preview', root_path, class: 'item audacious active'),
        link_to('Edit Profile', edit_owner_path,
                class: 'item audacious'),
        %{
        <div class="ui dropdown item">
          <span class="audacious">Projects</span>
          <i class="dropdown icon"></i>
          <div class="menu">
            #{link_to 'Listing', projects_path, class: 'item'}
            #{link_to 'Create', new_project_path, class: 'item'}
          </div>
        </div>
      }.html_safe
    else
      if controller.action_name == 'new'
        return link_to('Preview', root_path, class: 'item audacious'),
          link_to('Edit Profile', edit_owner_path,
                  class: 'item audacious'),
          %{
          <div class="ui dropdown item">
            <span class="audacious">Projects</span>
            <i class="dropdown icon"></i>
            <div class="menu">
              #{link_to 'Listing', projects_path, class: 'item'}
              #{link_to 'Create', new_project_path, class: 'active item'}
            </div>
          </div>
        }.html_safe
      else
        return link_to('Preview', root_path, class: 'item audacious'),
          link_to('Edit Profile', edit_owner_path,
                  class: 'item audacious'),
          %{
          <div class="ui dropdown item">
            <span class="audacious">Projects</span>
            <i class="dropdown icon"></i>
            <div class="menu">
              #{link_to 'Listing', projects_path, class: 'active item'}
              #{link_to 'Create', new_project_path, class: 'item'}
            </div>
          </div>
        }.html_safe
      end
    end
  end
end
