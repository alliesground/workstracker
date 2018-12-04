class MembershipRole < ApplicationRecord
  belongs_to :membership
  enum name: { admin: 0, normal: 1 }
end
