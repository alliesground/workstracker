require 'rails_helper'

describe 'ProjectsController', type: :request do
  describe 'GET /projects/new' do
    it 'responds with success' do
      get '/projects/new'
      expect(response).to have_http_status :success
      expect(response.body).to include "Create new project"
    end
  end

  describe 'POST /projects' do
    context 'with valid attributes' do
      it 'creates a project in the database' do
        project_attributes = attributes_for(:project)

        expect {
          post '/projects', params: { project: attributes_for(:project) }
        }.to change(Project, :count).by 1
      end
    end

    context 'with invalid attributes' do
      it 'does not create a project in the database' do
        expect {
          post '/projects', params: { project: attributes_for(:invalid_project) }
        }.to_not change(Project, :count)
      end
    end
  end
end
