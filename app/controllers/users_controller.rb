class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :admin_access_check?, except: %i[ new create ] ,unless: :format_json?
  protect_from_forgery unless: :format_json?
  before_action :authenticate_admin_token, :if => :format_json?
  helper_method :new_token
  
  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    if logged_in? and !is_admin?
      flash[:alert] = "You can't signup while being logged in"
      redirect_to home_index_path
    end
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        new_token @user,false
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render json: {:response=>"User created successfully",:user=> @user.username, token:token} }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password, :email)
    end
  
    # method for new token
    def new_token(user=nil, is_admin=false)
      if user.nil?
          user = User.find(params[:id])
          is_admin = @user.is_admin
      end     
      token = encode_token({user_id:user.id, is_admin:is_admin})
      @user.update_attribute(:api_token, token)
    end
    
    # private method
    def add(a,b)
      a+b
    end
end
