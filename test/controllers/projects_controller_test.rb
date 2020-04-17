require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def test_it_gets_new
    create(:owner)
    get new_project_url
    assert_response :success
  end

  def test_it_creates_a_project
    create(:owner)

    assert_difference('Project.count', 1) do
      post projects_url, params: {
        project: attributes_for(:project, attach_image: false) }
    end
  end

  def test_it_gets_index
    create(:owner)
    get projects_url
    assert_response :success
  end

  def test_it_gets_edit
    owner = create(:owner)
    project = build(:project)
    project.owner_id = owner.id
    project.save
    get edit_project_url(project)
    assert_response :success
  end

  def test_it_updates_a_project
    owner = create(:owner)
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
    project = build(:project)
    project.owner_id = owner.id
    project.save

    assert_difference('Project.count', -1) do
      delete project_path(project)
    end
  end
end
