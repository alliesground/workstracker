module Api::V1
  class ApiController < ApplicationController
    include Concerns::NestedResourcesParentFinder

    before_action :set_default_format
    before_action :authenticate_api_user!
    
    private

    def set_default_format
      request.format = :json
    end

    def render_error(resource:, status:)
      render json: resource, 
             status: status, 
             adapter: :json_api,
             serializer: ActiveModel::Serializer::ErrorSerializer
    end
    
  end
end
