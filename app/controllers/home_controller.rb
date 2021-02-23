class HomeController < ApplicationController

    def index
    end

    def login
        redirect_to home_index_path and return if !session[:user_id].nil? 
        if User.find_by(:username=>params["username"])
            user =  User.find_by_username(params["username"])
           if user.authenticate(params["password"])
                session[:user_id] = user.id
                flash[:alert] = "User logged in successfully"
                render home_index_path and return
           else
            flash[:alert] = "Wrong password"
           end
        else
            flash[:alert] = "User not found"
        end
    end

    def logout
        if session[:user_id].nil?
            redirect_to home_index_path
        else
            session[:user_id] = nil
        end
    end

end