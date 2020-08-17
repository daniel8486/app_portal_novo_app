require 'test_helper'

class Pages::DiceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pages_dice_index_url
    assert_response :success
  end

end
