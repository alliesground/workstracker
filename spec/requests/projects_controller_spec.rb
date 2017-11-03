require 'rails_helper'

describe 'Project management', type: :request do
  login

  it 'returns the information for the requested project', :vcr do
    project = create(:project)

    client = GithubWrapper::Client.new(
      access_token: ENV['TEST_USER_GITHUB_TOKEN']
    )

    client.create_repo(project.title)

    get project_url(project)
    expect(response.body).to include "test project"

    client.delete_repo(project.repo_full_name)
  end
end
