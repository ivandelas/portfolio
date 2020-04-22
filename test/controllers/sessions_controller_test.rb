require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'it gets login' do
    get login_url
    assert_response :success
  end

  test 'it deletes a session' do
    owner = create(:owner)

    post login_url, params: {
      session: { email: owner.email, password: '123456' } }

    delete logout_url
    assert_redirected_to root_url
    assert_equal 'You just logged out', flash[:info]
    assert_nil session[:owner_id]
  end

  test 'it creates a session if everything is ok' do
    owner = create(:owner)

    post login_url, params: {
      session: { email: owner.email, password: '123456' } }

    assert_redirected_to root_url
    assert_equal 'You are logged in', flash[:success]
    assert_equal owner.id, session[:owner_id]
  end

  test 'it does not create a session if the password is wrong' do
    owner = create(:owner)
    post login_url, params: {
      session: { email: owner.email, password: '12345' } }
    assert_equal 'Invalid credentials', flash[:error]
    assert_nil session[:owner_id]
  end
end
