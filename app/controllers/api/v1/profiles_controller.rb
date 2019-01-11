module Api::V1
  class ProfilesController < ApiController
    def index
      render json: current_api_user.email
    end
  end
end
