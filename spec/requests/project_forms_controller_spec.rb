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
      let(:repo_name) {"new test repo"}

      it 'creates a project' do
        expect_any_instance_of(ProjectForm).
          to receive(:create_github_repo).
          and_return({ name: repo_name })

        expect {
          post('/project_forms',
               params: { project_form: attributes_for(:project_form, name: repo_name) })
        }.to change(Project, :count)
      end

      it 'initiates a call to create github repository' do
        expect_any_instance_of(ProjectForm).
          to receive(:create_github_repo).
          and_return({ name: repo_name })

        post('/project_forms',
             params: { project_form: attributes_for(:project_form,
                                                    repo_name: repo_name) })

      end

      it 'redirects to the /projects/:id' do
        allow_any_instance_of(ProjectForm).
          to receive(:create_github_repo).
          and_return({name: repo_name})

        post('/project_forms',
             params: { project_form: attributes_for(:project_form) })

        expect(response).to redirect_to "/projects/#{Project.last.id}"
      end

      context 'when github raises an exception' do
        before do
          allow_any_instance_of(ProjectForm).
            to receive(:create_github_repo).
            and_raise(StandardError.new("Github Error"))
        end

        it 'does not create project and github repo' do
          expect {
            post('/project_forms',
                 params: { project_form: attributes_for(:project_form) })
          }.to_not change(Project, :count)
        end

        it 'renders new project form page' do
          post('/project_forms',
               params: { project_form: attributes_for(:project_form) })

          expect(response.body).to include "Create new project"
        end
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
