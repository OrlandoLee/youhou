require 'test_helper'

class ReserveControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
