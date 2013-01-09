require 'test_helper'

class BshareOneControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
