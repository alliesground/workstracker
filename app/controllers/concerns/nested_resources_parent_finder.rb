module NestedResourcesParentFinder
  extend ActiveSupport::Concern

  included do
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
  end

  def parent_object
    parent_class && parent_class.find_by_id(parent_id(parent_type))
  end

  private
  def parent_class
    parent_type && parent_type.to_s.classify.constantize
  end

  def parent_type
    self.class.parents.detect { |parent| parent_id(parent) }
  end

  def parent_id(parent)
    request.path_parameters["#{parent}_id".to_sym]
  end
end
