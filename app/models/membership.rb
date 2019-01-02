class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum role: { admin:0, normal: 1 }
end
