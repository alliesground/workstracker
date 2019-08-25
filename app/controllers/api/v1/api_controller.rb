module Api
  module V1
    class ApiController < ActionController::API
      include PublicActivity::StoreController

      include JSONAPI::ActsAsResourceController

      #skip_before_action :verify_authenticity_token
      #include DeviseTokenAuth::Concerns::SetUserByToken
      
      #protect_from_forgery with: :exception

      include Concerns::NestedResourcesParentFinder

      #before_action :authenticate_api_user!
    end
  end
end
