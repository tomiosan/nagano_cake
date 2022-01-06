require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get genres" do
    get admin_genres_url
    assert_response :success
  end

end
