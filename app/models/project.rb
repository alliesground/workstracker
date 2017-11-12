class Project < ApplicationRecord
  resourcify

  validates_presence_of :title
  validates_presence_of :repo_full_name

  belongs_to :user

  def repository_clone_url
    repo.clone_url
  end

  def repo
    github_client.repository(repo_full_name)
  end

  private

  def github_client
    @client ||= GithubWrapper::Client.new(
      access_token: user.github_profile_access_token
    )
  end
end
