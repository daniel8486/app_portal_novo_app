require 'test_helper'

class Pages::PointsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_points_index_url
    assert_response :success
  end

end
