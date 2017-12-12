require 'rails_helper'

describe 'Project maintainence', type: :request do
  login

  it 'provides user-interface to create a new project' do
    get '/projects/new'
    expect(response).to have_http_status :success
    expect(response.body).to include 'Create new project'
  end

  context 'with valid input' do
    it 'creates a new project' do
      post(
        '/projects', 
        params: { project: attributes_for(:project, user: @current_user) }
      )
      expect(Project.count).to eq 1
    end
  end

  context 'with invalid input' do
    it 'does not create a project, instead renders create new project page' do
      post(
        '/projects', 
        params: { project: attributes_for(:invalid_project, user: @current_user) }
      )
      expect(Project.count).to eq 0
      expect(response.body).to include "Create new project"
    end
  end

  context "when current_user accesses their project" do
    it 'gives access' do
      project = create(:project, user: @current_user)
      get project_url(project)
      expect(response.body).to include project.title
    end
  end

  context "when current_user accesses other users project" do
    it 'does not give access and redirects to root path' do
      project = create(:project)
      get project_url(project)
      expect(response).to redirect_to root_url
    end
  end
end
