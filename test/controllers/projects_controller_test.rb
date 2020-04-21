require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def test_it_redirects_new_if_no_owner_logged_in
    get new_project_url
    assert_redirected_to root_url
    assert_equal 'You must a logged in owner to perform that action', flash[:error]
  end

  def test_it_redirects_edit_if_no_owner_logged_in
    owner = create(:owner)
    project = owner.projects.create(attributes_for(:project))
    get edit_project_url(project)
    assert_redirected_to root_url
    assert_equal 'You must a logged in owner to perform that action', flash[:error]
  end

  def test_it_redirects_update_if_no_owner_logged_in
    owner = create(:owner)
    project = owner.projects.create(attributes_for(:project))

    patch project_url(project), params: {
      project: attributes_for(:project, title: 'Ten is greater than nine')
    }

    assert_redirected_to root_url
    assert_equal 'You must a logged in owner to perform that action', flash[:error]
  end

  def test_it_redirects_delete_if_no_owner_logged_in
    owner = create(:owner)
    project = owner.projects.create(attributes_for(:project))
    delete project_url(project)
    assert_redirected_to root_url
    assert_equal 'You must a logged in owner to perform that action', flash[:error]
  end

  def test_it_changes_nothing_if_owner_not_logged_in
    owner = create(:owner)
    project = owner.projects.create(attributes_for(:project))
    patch change_active_status_url(project), xhr: true
    assert_not project.active?
  end

  def test_it_redirects_create_if_no_owner_logged_in
    owner = create(:owner)
    post projects_url, params: { project: attributes_for(:project) }
    assert_redirected_to root_url
    assert_equal 'You must a logged in owner to perform that action', flash[:error]
  end

  def test_it_redirects_index_if_no_owner_logged_in
    get projects_url
    assert_redirected_to root_url
    assert_equal 'You must a logged in owner to perform that action', flash[:error]
  end

  def test_it_gets_new
    owner = create(:owner)
    login_owner(owner)
    get new_project_url
    assert_response :success
  end

  def test_it_creates_a_project
    owner = create(:owner)
    login_owner(owner)

    assert_difference('Project.count', 1) do
      post projects_url, params: {
        project: attributes_for(:project, attach_image: false) }
    end
  end

  def test_it_gets_index
    owner = create(:owner)
    login_owner(owner)
    get projects_url
    assert_response :success
  end

  def test_it_gets_edit
    owner = create(:owner)
    login_owner(owner)
    project = build(:project)
    project.owner_id = owner.id
    project.save
    get edit_project_url(project)
    assert_response :success
  end

  def test_it_updates_a_project
    owner = create(:owner)
    login_owner(owner)
    project = build(:project)
    project.owner_id = owner.id
    project.save
    old_title = project.title
    new_title = { 'title' => 'Another thing by title' }
    merged = project.attributes.merge(new_title)

    patch project_url(project), params: {
      project: merged
    }

    assert_not_equal old_title, project.reload.title
  end

  def test_it_deletes_a_project
    owner = create(:owner)
    login_owner(owner)
    project = build(:project)
    project.owner_id = owner.id
    project.save

    assert_difference('Project.count', -1) do
      delete project_path(project), xhr: true
    end
  end

  def test_it_toggles_active_status_of_project
    owner = create(:owner)
    login_owner(owner)
    project = build(:project)
    project.owner_id = owner.id
    project.save

    patch change_active_status_url(project), xhr: true
    assert project.reload.active?
  end
end
