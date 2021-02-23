ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  FactoryBot.reload
  include FactoryBot::Syntax::Methods
  # Add more helper methods to be used by all tests here...
end


class ActionDispatch::IntegrationTest
  def create_user(user="normal",email="normal@gmail.com",pass="normal")
    post users_path ,params:{"user[username]":user,"user[email]":email,"user[password]":pass}
    log_user_out
  end

  def create_admin
    post users_path ,params:{"user[username]":"admin","user[email]":"admin@gmail.com","user[password]":"admin"}
    @user = User.find_by(:username=>"admin")
    @user.update_attribute(:is_admin,true)
    log_user_out
  end

  def log_user_out
    get home_logout_path
  end

  def log_user_in(user="normal",pass="normal")
    post home_login_path, params:{username:user, password:pass}
  end
  
  def log_admin_in
    post home_login_path, params:{username:"admin", password:"admin"}
  end
  
end