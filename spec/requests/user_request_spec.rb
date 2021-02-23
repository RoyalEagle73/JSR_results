require 'rails_helper'

RSpec.describe "Users", type: :request do
    before do
        create_admin
        create_user
    end
    
    context "admin actions" do
        before do
            log_admin_in
        end
    
        it "Users index page when admin user logged in" do
            get users_path
            assert_response :success
        end

        it "Users show page when admin user logged in" do
            get users_path(User.last.id)
            assert_response :success
        end
        
        it "New users page when admin user logged in" do
            get new_user_path
            assert_response :success
        end
        
        it "Edit users page when admin user logged in" do
            get edit_user_path(User.last)
            assert_response :success
        end
        
        it "deleting a user" do
            create_user("hakuna", "hakuna@gmail.com", "password")
            log_admin_in
            delete user_path(User.last)
            assert_redirected_to users_path
        end

        it "Create users via POST with admin logged in" do
            post users_path params:{"user[username]":"Hello", "user[email]":"deepakchauhan@gmail.com", "user[password]":"password"}
            assert_redirected_to user_path(User.last.id)
          end
          
        it "Create users via POST with admin logged in with incorrect email" do
            post users_path params:{"user[username]":"Hello", "user[email]":"deepakchauhan", "user[password]":"password"}
            assert_response :unprocessable_entity
        end
        
        it "Create users via POST with admin logged in with incorrect username" do
            post users_path params:{"user[username]":"   ", "user[email]":"deepakchauhan@gmail.com", "user[password]":"password"}
            assert_response :unprocessable_entity
        end

        it "Create users via POST with admin logged in with duplicate username" do
            post users_path params:{"user[username]":"admin", "user[email]":"deepakchauhan@gmail.com", "user[password]":"password"}
            assert_response :unprocessable_entity
        end
        
    end


    context "normal user actions" do
        before do
            log_user_in
        end

        it "Users index page when normal user logged in" do
            get users_path
            assert_redirected_to home_index_path
        end

        it "Users show page when normal user logged in" do
            get users_path(User.last.id)
            assert_redirected_to home_index_path
        end

        it "New users page when normal user logged in" do
            get new_user_path
            assert_redirected_to home_index_path
        end

        it "Edit users page when normal user logged in" do
            get edit_user_path(User.last)
            assert_redirected_to home_index_path
        end
        
    end

    context "Actions which does not require login" do
        it "Users index page when logged out" do
            get users_path
            assert_redirected_to home_index_path
        end

        it "Users show page when logged out" do
            get users_path(User.last.id)
            assert_redirected_to home_index_path
        end

        it "New users page when logged out" do
            get new_user_path
            assert_response :success
        end

        it "Edit users page when logged out" do
            get edit_user_path(User.last)
            assert_redirected_to home_index_path
        end

        it "Create users via POST with no user logged in" do
            post users_path params:{"user[username]":"Hello", "user[email]":"deepakchauhan@gmail.com", "user[password]":"password"}
            assert_redirected_to user_path(User.last.id)
          end
      
        it "Create users via POST with no user logged in with incorrect email" do
            post users_path params:{"user[username]":"Hello", "user[email]":"deepakchauhan", "user[password]":"password"}
            assert_response :unprocessable_entity
        end
    
        it "Create users via POST with no user logged in with incorrect username" do
            post users_path params:{"user[username]":"123123 123123", "user[email]":"deepakchauhan@gmail.com", "user[password]":"password"}
            assert_response :unprocessable_entity
        end
      
        it "Create users via POST with no user logged in with duplicate email" do
            post users_path params:{"user[username]":"hello", "user[email]":"admin@gmail.com", "user[password]":"password"}
            assert_response :unprocessable_entity
        end

        it "private method test" do
            obj = UsersController.new
            assert_equal obj.send(:add,5,6),11
        end
    end
    
end
