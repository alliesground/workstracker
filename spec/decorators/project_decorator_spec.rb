require 'rails_helper'

RSpec.describe ProjectDecorator do
  describe '#repository_clone_url' do
    it 'returns the clone_url for a projects github repository' do
      client = double("Octokit::Client") 
      project = create(:project)
      project_decorator = ProjectDecorator.new(project)

      repository = double(
        "Sawyer::Resource",
        { clone_url: "https://github.com/#{project.repo_full_name}" }
      )

      allow(client).
        to receive(:repository).
        with(project.repo_full_name).
        and_return(repository)

      allow(project_decorator).
        to receive(:github_client).
        and_return(client)

      expect(project_decorator.repository_clone_url).to eq "https://github.com/#{project.repo_full_name}"
    end
  end
end
