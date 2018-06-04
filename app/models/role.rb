class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :users_roles

  belongs_to :resource,
             :polymorphic => true,
             :optional => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  scopify

  def self.scoped_to(resource_id:)
    where(arel_table[:resource_id].eq(resource_id).
          and(arel_table[:name].not_eq(nil)))
  end
end
