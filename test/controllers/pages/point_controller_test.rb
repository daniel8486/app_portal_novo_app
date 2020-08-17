require 'test_helper'

class Pages::PointControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_point_index_url
    assert_response :success
  end

end
