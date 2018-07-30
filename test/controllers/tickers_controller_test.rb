require 'test_helper'

class TickersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get tickers_show_url
    assert_response :success
  end

end
