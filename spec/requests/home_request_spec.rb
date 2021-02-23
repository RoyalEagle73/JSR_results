require 'rails_helper'

RSpec.describe "Homes", type: :request do
    context "home_test" do
        before do
            create_user
        end 

        it "login failed due to invalid user" do
            log_user_in("normal123","chauhan")
            expect(flash.now[:alert]).to eq("User not found")
            assert_equal flash.now[:alert],"User not found"
          end
          
        it "login failed due to wrong password" do
            log_user_in("normal","password")
            expect(flash.now[:alert]).to eq("Wrong password")
        end
          
        it "login successfull" do
            log_user_in("normal","normal")
            expect(flash.now[:alert]).to eq("User logged in successfully")
        end 
    end
end
