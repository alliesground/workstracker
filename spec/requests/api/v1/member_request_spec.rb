require 'rails_helper'
require 'api_helper'

describe 'Api::V1::MembersController', type: :request do
  let(:user) { create(:user, email: 'test_user@example.com', password: 'password') }
  before :each do
    sign_in user
  end

  describe 'GET /api/projects/:project_id/members' do
    let(:project) { create(:project) }

    it 'renders json representation for project members' do
      create(:membership, user: user, project: project)
      get "/api/projects/#{project.id}/members", headers: auth_headers

      members_response = json_response
      expect(members_response[:data].size).to eq 1
    end
  end
end
