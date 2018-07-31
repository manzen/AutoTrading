require 'test_helper'

class SettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @setting = settings(:one)
  end

  test "should get index" do
    get settings_url
    assert_response :success
  end

  test "should get new" do
    get new_setting_url
    assert_response :success
  end

  test "should create setting" do
    assert_difference('Setting.count') do
      post settings_url, params: { setting: { buy_count: @setting.buy_count, hour: @setting.hour, increase_conditions: @setting.increase_conditions, increase_percent: @setting.increase_percent, reduction_conditions: @setting.reduction_conditions, reduction_percent: @setting.reduction_percent, shell_count: @setting.shell_count } }
    end

    assert_redirected_to setting_url(Setting.last)
  end

  test "should show setting" do
    get setting_url(@setting)
    assert_response :success
  end

  test "should get edit" do
    get edit_setting_url(@setting)
    assert_response :success
  end

  test "should update setting" do
    patch setting_url(@setting), params: { setting: { buy_count: @setting.buy_count, hour: @setting.hour, increase_conditions: @setting.increase_conditions, increase_percent: @setting.increase_percent, reduction_conditions: @setting.reduction_conditions, reduction_percent: @setting.reduction_percent, shell_count: @setting.shell_count } }
    assert_redirected_to setting_url(@setting)
  end

  test "should destroy setting" do
    assert_difference('Setting.count', -1) do
      delete setting_url(@setting)
    end

    assert_redirected_to settings_url
  end
end
