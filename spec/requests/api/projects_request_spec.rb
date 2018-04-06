require 'rails_helper'

describe 'ProjectsController', type: :request do
  let(:user) { create(:user, email: 'test_user@example.com') }

  describe 'GET /api/projects' do
    it 'renders json representation for users projects' do
      projects = 3.times { create(:project, user: user) }

      get '/api/projects', headers: auth_headers(user)
      projects_response = json_response

      expect(projects_response[:projects].size).to eq 3
    end
  end

  describe 'POST /api/projects' do
    before :each do
      post('/api/projects',
           params: { project: attributes_for(:project) })
    end

    context 'with valid input' do
      it 'creates a new project in the database'
      it 'renders the json representation for the project just created'
      it { should respond_with 201 }
    end
  end
end
