require 'test_helper'

class ExecutionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get executions_show_url
    assert_response :success
  end

end
