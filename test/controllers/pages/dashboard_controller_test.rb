require 'test_helper'

class Pages::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_dashboard_index_url
    assert_response :success
  end

end
