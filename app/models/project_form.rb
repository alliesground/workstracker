class ProjectForm
  include ActiveModel::Model

  attr_accessor :project_title,
                :project_description,
                :repo_name,
                :current_user

  validates_presence_of :project_title, :repo_name

  def save(current_user:)
    self.current_user = current_user

    return false unless valid?

    begin
      ActiveRecord::Base.transaction do
        repo = create_github_repo

        @project = current_user.projects.create!(
          title: project_title,
          description: project_description,
          repo_full_name: repo.full_name
        )
      end
    rescue Octokit::ClientError => e
      present_error(e)
      return false
    end

    true
  end

  private

  def present_error(e)
    e.errors.each do |error|
      if error[:field] == "name"
        errors.add(:repo_name, error[:message])
      else
        errors.add(:base, error[:message])
      end
    end
  end

  def create_github_repo
    client = GithubWrapper::Client.new(
      access_token: current_user.github_profile_access_token
    )

    client.create_repo(repo_name)
  end
end
