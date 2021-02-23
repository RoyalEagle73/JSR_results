require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "create user with all conditions satisfied" do
    @user = User.new(username:"admin", email:"admin@gmail.com", password:"password")
    expect(@user.save).to eq(true)
  end

  it "create user with malformed username" do
    @user = User.new(username:"admin 404", email:"admin@gmail.com", password:"password")
    expect(@user.save).to eq(false)
  end

  it "create user with malformed email" do
    @user = User.new(username:"admin", email:"admin@gmail", password:"password")
    expect(@user.save).to eq(false)
  end

  it "creating user with duplicate email" do
    User.create(username:"admin",email:"admin@gmail.com",password:"password")
    @user = User.new(username:"admin1", email:"admin@gmail.com", password:"password")
    expect(@user.save).to eq(false)
  end
  
  it "creating user with duplicate username" do
    User.create(username:"admin",email:"admin@gmail.com",password:"password")
    @user = User.new(username:"admin", email:"admin1@gmail.com", password:"password")
    expect(@user.save).to eq(false)
  end

  it "creating user with email missing" do
    @user = User.new(username:"admin", password:"password")
    expect(@user.save).to eq(false)
  end

  it "creating user with username missing" do
    @user = User.new( email:"admin1@gmail.com", password:"password")
    expect(@user.save).to eq(false)
  end

  it "creating user with password missing" do
    @user = User.new(username:"admin", email:"admin1@gmail.com")
    expect(@user.save).to eq(false)
  end

  it "creating user with password containing whitespaces" do
    @user = User.new(username:"admin", email:"admin1@gmail.com", password:"")
    expect(@user.save).to eq(false)
  end

end
