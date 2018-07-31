require "application_system_test_case"

class SettingsTest < ApplicationSystemTestCase
  setup do
    @setting = settings(:one)
  end

  test "visiting the index" do
    visit settings_url
    assert_selector "h1", text: "Settings"
  end

  test "creating a Setting" do
    visit settings_url
    click_on "New Setting"

    fill_in "Buy Count", with: @setting.buy_count
    fill_in "Hour", with: @setting.hour
    fill_in "Increase Conditions", with: @setting.increase_conditions
    fill_in "Increase Percent", with: @setting.increase_percent
    fill_in "Reduction Conditions", with: @setting.reduction_conditions
    fill_in "Reduction Percent", with: @setting.reduction_percent
    fill_in "Shell Count", with: @setting.shell_count
    click_on "Create Setting"

    assert_text "Setting was successfully created"
    click_on "Back"
  end

  test "updating a Setting" do
    visit settings_url
    click_on "Edit", match: :first

    fill_in "Buy Count", with: @setting.buy_count
    fill_in "Hour", with: @setting.hour
    fill_in "Increase Conditions", with: @setting.increase_conditions
    fill_in "Increase Percent", with: @setting.increase_percent
    fill_in "Reduction Conditions", with: @setting.reduction_conditions
    fill_in "Reduction Percent", with: @setting.reduction_percent
    fill_in "Shell Count", with: @setting.shell_count
    click_on "Update Setting"

    assert_text "Setting was successfully updated"
    click_on "Back"
  end

  test "destroying a Setting" do
    visit settings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Setting was successfully destroyed"
  end
end
