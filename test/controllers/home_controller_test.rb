require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    create_user
  end

  test "login failed due to invalid user" do
    log_user_in("normal123","chauhan")
    assert_equal flash.now[:alert], "User not found"
  end
  
  test "login failed due to wrong password" do
    log_user_in("normal","password")
    assert_equal "Wrong password", flash.now[:alert]
  end
  
  test "login successfull" do
    log_user_in("normal","normal")
    assert_equal "User logged in successfully", flash.now[:alert]
  end


  # Request testing
  test "request login testing" do 
    p get home_login_path
    fill_in "username",	with: "normal"
    fill_in "password",	with: "normal"
    click_button 'submit'
    
    assert_redirected_to home_index_path
  end

end
