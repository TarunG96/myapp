class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def facebook
        @user = UserProvider.find_for_facebook_oauth(request.env["omniauth.auth"])

        if @user.persisted?
          sign_in_and_redirect @user, :event => :authentication               
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
    end
    
    
    

    def twitter
      @client  = Twitter::REST::Client.new do |config|
      config.consumer_key        = "CSJLMOtBRbDMcX1tY1M02XmjO"
      config.consumer_secret     = "lY0YCBmh5NsMN4WB3miwKY8kYMtsmeJbcUg3RQG6oLd3ZG0EdD"
      end

        auth = request.env["omniauth.auth"]
        $tweets = @client.user_timeline(auth[:info][:nickname])  
        
        @user = UserProvider.find_for_twitter_oauth(request.env["omniauth.auth"])
      
        if @user.persisted?         
          sign_in_and_redirect @user, :event => :authentication
        else
          session["devise.twitter_data"] = request.env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
    end
    
end