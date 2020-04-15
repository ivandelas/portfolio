require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  def test_should_get_root_as_index
    get root_url
    assert_response :success
    assert_equal 'index', @controller.action_name
    assert_equal 'projects', @controller.controller_name
  end
end
