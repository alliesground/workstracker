class Api::V1::ProfilesController < ApiController
  def index
    render json: current_api_user.email
  end
end
