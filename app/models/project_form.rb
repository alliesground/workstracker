class ProjectForm
  include ActiveModel::Model

  attr_accessor :project_title,
                :repo_name,
                :repo_description

  validates_presence_of :project_title

  def save
    return false unless valid?

    begin
      ActiveRecord::Base.transaction do
        create_github_repo
        @project = Project.create!(title: project_title)
        #@project.create_repository(name: repo_name, description: repo_description)
      end
    rescue => e
      errors.add(:repo_name, message: "#{e.message}")
      return false
    end
    true
  end

  private

  def create_github_repo
#    github_wrapper = GithubWrapper::Repository.new
#    result = github_wrapper.create_repository!
  end
end
