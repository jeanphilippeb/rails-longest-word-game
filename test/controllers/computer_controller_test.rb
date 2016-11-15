require 'test_helper'

class ComputerControllerTest < ActionDispatch::IntegrationTest
  test "should get game" do
    get computer_game_url
    assert_response :success
  end

  test "should get score" do
    get computer_score_url
    assert_response :success
  end

end
