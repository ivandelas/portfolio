require 'test_helper'

class OwnerControllerTest < ActionDispatch::IntegrationTest
  def test_it_gets_new
    get new_owner_url
    assert_response :success
  end

  def test_it_creates_owner
    assert_difference('Owner.count', 1) do
      post owner_url, params: { owner: attributes_for(:owner) }
    end
  end
end
