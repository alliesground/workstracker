class Project < ApplicationRecord
  resourcify

  validates_presence_of :title
  validates_presence_of :repo_full_name

  belongs_to :user

  def self.to_join(id:)
    select('title').where(id: id).limit(1)
  end
end
