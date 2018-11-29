class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum type: { admin: 0, normal: 1 }
end
