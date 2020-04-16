require 'test_helper'

class MastermindControllerTest < ActionDispatch::IntegrationTest
  test "should get base" do
    get mastermind_base_url
    assert_response :success
  end

end
