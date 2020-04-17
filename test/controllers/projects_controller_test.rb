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
end
