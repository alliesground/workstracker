class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :resource, polymorphic: true

  enum role: { admin:0, normal: 1 }
end
