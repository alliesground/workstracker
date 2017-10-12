module RequestMacros
  def login(user=nil)
		before(:each) do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:github]

      get '/users/auth/github/callback'
		end
	end
end
