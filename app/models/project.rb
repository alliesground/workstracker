class Project < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :repo_full_name

  def repository_clone_url(user:)
    repo(user: user).clone_url
  end

  def repo(user:)
    github_client(user: user).repository(repo_full_name)
  end

  private

  def github_client(user:)
    @client ||= GithubWrapper::Client.new(
      access_token: user.github_profile_access_token
    )
  end
end
