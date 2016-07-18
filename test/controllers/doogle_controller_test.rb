require 'test_helper'

class DoogleControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get doogle_search_url
    assert_response :success
  end

end
