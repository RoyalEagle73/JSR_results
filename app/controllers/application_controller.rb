class ApplicationController < ActionController::Base
   helper_method :logged_in?, :is_admin?, :format_json?, :encode_token, :decode_token, :authenticate_token, :new_token

   Key = "secret"

   def encode_token(payload)
     JWT.encode(payload,Key)
   end

   def auth_header
     request.headers['Authorization']
   end

   def decode_token
     if auth_header
          token = auth_header.split()[1]
          begin
               data = JWT.decode(token,Key)
          rescue JWT::DecodeError
               nil
          end
     end
   end

   def authenticate_token
     if decode_token.nil?
          render json: {"Erorr" => "User not verified"}
     else
          true
     end
   end

   def authenticate_admin_token
     token_data = decode_token
     if token_data.nil?
          render json: {"Erorr" => "Invalid Token"}
     else
          unless token_data[0]["is_admin"]
               render json: {"Erorr" => "Restricted zone, only for admins"}
          end
     end
     true
   end

   
   def format_json?
     request.format.json?
   end

   # Web Authentication methods
   def logged_in?
        !session[:user_id].nil?
   end

   def is_admin?
        logged_in? and User.find(session[:user_id]).is_admin
   end

   def admin_access_check?
        unless logged_in? and is_admin?
            redirect_to home_index_path, notice: "You are not authorized to access the page"
        end
   end

   def normal_access_check?
        unless logged_in?
            redirect_to home_index_path, notice: "You must be logged in to access the page"
        end
    end
end
