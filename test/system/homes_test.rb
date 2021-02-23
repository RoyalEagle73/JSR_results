require "application_system_test_case"

class HomesTest < ApplicationSystemTestCase
  # Request testing
  test "request login testing" do 
    User.create(username:"normal", email:"normal@gmail.com", password:"normal")
    visit home_login_path
    fill_in "username",	with: "normal"
    fill_in "password",	with: "normal"
    click_button 'submit'
    assert_response :success
    assert_select "h1", "home#index"
  end
end
