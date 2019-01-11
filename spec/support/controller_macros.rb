module ControllerMacros
  def login(user=nil)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in (user || create(:user))
    end
  end
end
