class Users::SessionsController < Devise::SessionsController
  #respond_to :json
  def new
    super do |resource|
      resource.email = params[:email].presence
    end
  end
end
