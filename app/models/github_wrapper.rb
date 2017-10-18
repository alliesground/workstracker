class GithubWrapper

  class Client
    attr_reader :octokit_client

    def initialize(access_token:)
      @octokit_client ||= Octokit::Client.new(
        access_token: access_token
      )
    end

    def create_repo(name)
      octokit_client.create_repository(name, auto_init: true)
    end

    def delete_repo(full_name)
      octokit_client.delete_repository(full_name)
    rescue Octokit::NotFound
    end
  end
end
