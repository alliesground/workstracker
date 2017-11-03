require 'rails_helper'

RSpec.describe GithubWrapper, type: :model do

  describe GithubWrapper::Client do
    let(:client) do
      GithubWrapper::Client.new(
        access_token: ENV["TEST_USER_GITHUB_TOKEN"]
      )
    end

    describe "#create_repo", :vcr do
      it "creates a github repository for the authenticated user" do
        repository = client.create_repo("my-repo")
        expect(repository.name).to eq("my-repo")

        #cleanup
        client.delete_repo(repository.full_name)
      end
    end

    describe '#repository', :vcr do
      it "fetches the github repository for a given repo full name" do
        repo = client.create_repo("test-repo")
        expect(client.repository(repo.full_name).id).to eq repo.id

        #cleanup
        client.delete_repo(repo.full_name)
      end
    end
  end
end
