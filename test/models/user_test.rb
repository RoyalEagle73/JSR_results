require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  test "create user with all conditions satisfied" do
    @user = User.new(username:"admin", email:"admin@gmail.com", password:"password")
    assert_equal true,@user.save
  end

  test "create user with malformed username" do
    @user = User.new(username:"admin 404", email:"admin@gmail.com", password:"password")
    assert_equal false,@user.save
  end

  test "create user with malformed email" do
    @user = User.new(username:"admin", email:"admin@gmail", password:"password")
    assert_equal false,@user.save
  end

  test "creating user with duplicate email" do
    User.create(username:"admin",email:"admin@gmail.com",password:"password")
    @user = User.new(username:"admin1", email:"admin@gmail.com", password:"password")
    assert_equal false,@user.save
  end
  
  test "creating user with duplicate username" do
    User.create(username:"admin",email:"admin@gmail.com",password:"password")
    @user = User.new(username:"admin", email:"admin1@gmail.com", password:"password")
    assert_equal false,@user.save
  end

  test "creating user with email missing" do
    @user = User.new(username:"admin", password:"password")
    assert_equal false,@user.save
  end

  test "creating user with username missing" do
    @user = User.new( email:"admin1@gmail.com", password:"password")
    assert_equal false,@user.save
  end

  test "creating user with password missing" do
    @user = User.new(username:"admin", email:"admin1@gmail.com")
    assert_equal false,@user.save
  end

  test "creating user with password containing whitespaces" do
    @user = User.new(username:"admin", email:"admin1@gmail.com", password:"")
    assert_equal false,@user.save
  end

end
