class ApiController < ApplicationController
  before_action :set_default_format
  before_action :authenticate_api_user!

  protected

  class << self
    @@parents = []

    def parent_resources(*parents)
      @@parents = parents
    end

    def parents
      @@parents
    end
  end

  def parent_id(parent)
    request.path_parameters["#{parent}_id".to_sym]
  end

  def parent_type
    self.class.parents.detect { |parent| parent_id(parent) }
  end

  def parent_class
    parent_type && parent_type.to_s.classify.constantize
  end

  def parent_object
    parent_class && parent_class.find_by_id(parent_id(parent_type))
  end
  
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
