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

  def test_it_gets_edit
    owner = create(:owner)
    login_owner(owner)
    get edit_owner_url
    assert_response :success
  end

  def test_it_updates_owner
    owner = create(:owner)
    login_owner(owner)
    old_name = owner.name
    put owner_url, params: { owner: attributes_for(:owner, name: 'Bob Smith') }
    assert_not_equal old_name, owner.reload.name
  end
end
