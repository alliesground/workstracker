class ProjectDecorator < Draper::Decorator
  delegate_all

  def repository_clone_url
    github_client.repository(object.repo_full_name).clone_url
  end

  private

  def github_client
    @client ||= GithubWrapper::Client.new(
      access_token: user.github_profile_access_token
    )
  end
end
