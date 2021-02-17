require "test_helper"

class BrowseControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get browse_home_url
    assert_response :success
  end
end
