require 'rails_helper'

describe 'ProjectFormsController', type: :request do
  login

  describe 'GET /project_forms/new' do
    it 'responds with success' do
      get '/project_forms/new'
      expect(response).to have_http_status :success
      expect(response.body).to include "Create new project"
    end
  end

  describe 'POST /project_forms' do

    context 'with valid attributes' do
      before :each do
        expect_any_instance_of(ProjectForm).
          to receive(:create_github_repo).
          and_return({ name: "My-first-test-repository" })

        post(
          '/project_forms',
          params: { project_form: attributes_for(:project_form) }
        )
      end

      it 'creates a project' do
        expect(Project.count).to eq 1
      end

      it 'redirects to the /projects/:id' do
        expect(response).to redirect_to "/projects/#{Project.last.id}"
      end
    end

    context 'when github raises an exception' do
      before :each do
        expect_any_instance_of(ProjectForm).
          to receive(:create_github_repo).
          and_raise(StandardError.new("Github Error"))

        post(
          '/project_forms',
          params: { project_form: attributes_for(:project_form) }
        )
      end

      it 'rolls back project creation' do
        expect(Project.count).to eq 0
      end

      it 'renders new project form page' do
        expect(response.body).to include "Create new project"
      end
    end

    context 'with invalid attributes' do
      it 'does not create a project in the database' do
        expect {
          post('/project_forms',
               params: { project_form: attributes_for(:invalid_project_form) })
        }.to_not change(Project, :count)
      end
    end 
  end
end
