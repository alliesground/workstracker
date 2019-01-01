class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_one :membership_role
end
