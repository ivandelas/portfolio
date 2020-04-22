require 'test_helper'

class MastermindControllerTest < ActionDispatch::IntegrationTest
  def test_it_gets_base_if_owner_available
    create(:owner)
    get root_url
    assert_response :success
  end

  def test_it_redirects_to_new_owner_if_no_owner_available
    get root_url
    assert_redirected_to new_owner_url
  end
end
