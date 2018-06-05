require 'rails_helper'
require 'api_helper'

describe 'Api::V1::ProjectsController', type: :request do
  let(:user) { create(:user, email: 'test_user@example.com', password: 'password', confirmed_at: DateTime.now) }
  before :each do
    sign_in user
  end

  describe 'GET /api/projects' do
    before :each do
      3.times { create(:project, user: user) }
      get '/api/projects', headers: auth_headers
    end

    it 'renders json representation for users projects' do
      projects_response = json_response

      expect(projects_response[:data].size).to eq 3
    end
    
    it 'responds with success status' do
      expect(response).to have_http_status 200
    end
  end

  describe 'POST /api/projects' do
    context 'with valid request' do
      before :each do
        post('/api/projects',
             params: {
              data: {
                type: 'projects',
                attributes: { title: 'new project' }
              }
             },
             headers: auth_headers)
      end

      it 'creates a new project in the database' do
        expect(Project.count).to eq 1
      end

      it 'renders the json representation for the project just created' do
        project_response =  json_response

        expect(project_response[:data][:type]).to eq 'projects'
        expect(project_response[:data][:attributes][:title]).to eq 'new project'
      end

      it 'responds with status created' do
        expect(response).to have_http_status :created
      end
    end

    context 'with invalid request' do
      context 'when content-type is not in json-api format' do
        it 'responds with status 422' do
          post('/api/projects',
               params: { project: attributes_for(:project) },
               headers: auth_headers)

          expect(response).to have_http_status 422
        end
      end

      context 'when data is invalid' do
        before :each do
          post('/api/projects',
               params: {
                type: 'projects',
                attributes: attributes_for(:invalid_project)
               },
               headers: auth_headers)
        end

        it 'does not create a project in the database' do
          expect(Project.count).to eq 0
        end

        it 'renders an errors json explaining the issue' do
          expect(json_response).to have_key :errors
          expect(json_response[:errors].first[:detail]).to include "can't be blank"
        end

        it 'responds with status 422' do
          expect(response).to have_http_status 422
        end
      end
    end
  end
end
