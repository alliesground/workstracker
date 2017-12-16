class Project < ApplicationRecord
  resourcify

  validates_presence_of :title

  belongs_to :user

  def self.to_join(id:)
    select('title').where(id: id).limit(1)
  end
end 
