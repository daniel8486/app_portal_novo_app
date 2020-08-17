require 'test_helper'

class Users::LoginControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_login_index_url
    assert_response :success
  end

end
