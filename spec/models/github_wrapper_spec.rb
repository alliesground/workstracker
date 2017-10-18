require 'rails_helper'

RSpec.describe GithubWrapper, type: :model do

  describe GithubWrapper::Client do
    let(:github_wrapper_client) do
      GithubWrapper::Client.new(
        access_token: ENV["TEST_USER_GITHUB_TOKEN"]
      )
    end

    describe "#create_repo" do
      it "creates a github repository for the authenticated user" do
        repository = github_wrapper_client.create_repo("my-repo")
        expect(repository.name).to eq("my-repo")

        #cleanup
        github_wrapper_client.delete_repo(repository.full_name)
      end
    end
  end
end
