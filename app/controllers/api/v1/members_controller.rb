module Api::V1
  class MembersController < ApiController
    parent_resources :project

    def index
      render json: parent_object.members
    end
  end
end
