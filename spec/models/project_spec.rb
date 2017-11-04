require 'rails_helper'

describe Project, type: :model do
  before :each do
    #@user = create(:user)
    @project = create(:project)
    @repository = double(
      "Sawyer::Resource",
      { clone_url: "https://github.com/#{@project.repo_full_name}" }
    )
  end

  describe '#repository_clone_url' do
    it 'returns the clone_url for a projects github repository' do
      repository =  double(
        "Sawyer::Resource",
        { clone_url: "https://github.com/#{@project.repo_full_name}" }
      )

      allow(@project).
        to receive(:repo).
        and_return(repository)

      expect(@project.repository_clone_url).to eq repository.clone_url
    end
  end

  describe '#repo' do
    it 'returns a github repository object' do
      client = double("Octokit::Client")

      allow(client).
        to receive(:repository).
        with(@project.repo_full_name).
        and_return(@repository)

      allow(@project).
        to receive(:github_client).
        and_return(client)

      expect(@project.repo).to eq @repository
    end
  end
end
