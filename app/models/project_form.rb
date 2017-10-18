class ProjectForm
  include ActiveModel::Model

  attr_accessor :project_title,
                :repo_name,
                :repo_description,
                :current_user

  validates_presence_of :project_title

  def save(current_user:)
    self.current_user = current_user

    return false unless valid?

    begin
      ActiveRecord::Base.transaction do
        create_github_repo
        @project = Project.create!(title: project_title)
      end
    rescue => e
      errors.add(:repo_name, message: "#{e.message}")
      return false
    end
    true
  end

  private

  def create_github_repo
    client = GithubWrapper::Client.new(
      access_token: current_user.github_profile_access_token
    )

    client.create_repo(repo_name)
  end
end
