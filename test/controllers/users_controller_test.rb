require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    create_admin
    create_user
  end

  # Tests for Index
  test "Users index page when logged out" do
    get users_path
    assert_redirected_to home_index_path
  end

  test "Users index page when normal user logged in" do
    log_user_in
    get users_path
    assert_redirected_to home_index_path
  end
  
  test "Users index page when admin user logged in" do
    log_admin_in
    get users_path
    assert_response :success
  end


  # Tests for show
  test "Users show page when logged out" do
    get users_path(User.last.id)
    assert_redirected_to home_index_path
  end

  test "Users show page when normal user logged in" do
    log_user_in
    get users_path(User.last.id)
    assert_redirected_to home_index_path
  end
  
  test "Users show page when admin user logged in" do
    log_admin_in
    get users_path(User.last.id)
    assert_response :success
  end

  # Test for new 
  test "New users page when logged out" do
    get new_user_path
    assert_response :success
  end

  test "New users page when normal user logged in" do
    log_user_in
    get new_user_path
    assert_redirected_to home_index_path
  end
  
  test "New users page when admin user logged in" do
    log_admin_in
    get new_user_path
    assert_response :success
  end
  
  # Test for edit 
  test "Edit users page when logged out" do
    get edit_user_path(User.last)
    assert_redirected_to home_index_path
  end

  test "Edit users page when normal user logged in" do
    log_user_in
    get edit_user_path(User.last)
    assert_redirected_to home_index_path
  end

  test "Edit users page when admin user logged in" do
    log_admin_in
    get edit_user_path(User.last)
    assert_response :success
  end

  # Test for POST Create action 
  test "Create users via POST with no user logged in" do
    post users_path params:{"user[username]":"Hello", "user[email]":"deepakchauhan@gmail.com", "user[password]":"password"}
    assert_redirected_to user_path(User.last.id)
  end

  test "Create users via POST with admin logged in" do
    log_admin_in
    post users_path params:{"user[username]":"Hello", "user[email]":"deepakchauhan@gmail.com", "user[password]":"password"}
    assert_redirected_to user_path(User.last.id)
  end
  
  test "Create users via POST with admin logged in with incorrect email" do
    log_admin_in
    post users_path params:{"user[username]":"Hello", "user[email]":"deepakchauhan", "user[password]":"password"}
    assert_response :unprocessable_entity
  end

  test "Create users via POST with no user logged in with incorrect email" do
    post users_path params:{"user[username]":"Hello", "user[email]":"deepakchauhan", "user[password]":"password"}
    assert_response :unprocessable_entity
  end

  test "Create users via POST with admin logged in with incorrect username" do
    log_admin_in
    post users_path params:{"user[username]":"   ", "user[email]":"deepakchauhan@gmail.com", "user[password]":"password"}
    assert_response :unprocessable_entity
  end

  test "Create users via POST with no user logged in with incorrect username" do
    post users_path params:{"user[username]":"123123 123123", "user[email]":"deepakchauhan@gmail.com", "user[password]":"password"}
    assert_response :unprocessable_entity
  end


  test "Create users via POST with admin logged in with duplicate username" do
    log_admin_in
    post users_path params:{"user[username]":"admin", "user[email]":"deepakchauhan@gmail.com", "user[password]":"password"}
    assert_response :unprocessable_entity
  end

  test "Create users via POST with no user logged in with duplicate email" do
    post users_path params:{"user[username]":"hello", "user[email]":"admin@gmail.com", "user[password]":"password"}
    assert_response :unprocessable_entity
  end
  
  # Test for Destroy action
  test "deleting a user" do
    create_user("hakuna", "hakuna@gmail.com", "password")
    log_admin_in
    delete user_path(User.last)
    assert_redirected_to users_path
  end

  # Private method test
  test "private method test" do
    obj = UsersController.new
    assert_equal obj.send(:add,5,6),11
  end

end
