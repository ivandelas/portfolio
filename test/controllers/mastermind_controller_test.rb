require 'test_helper'

class MastermindControllerTest < ActionDispatch::IntegrationTest
  def setup
    create(:owner)
  end

  test "should get base" do
    get root_url
    assert_response :success
  end
end
