require 'rails_helper'

describe 'ProjectsController', type: :request do
  describe 'GET /projects/new' do
    it 'responds with success' do
      get '/projects/new'
      expect(response).to have_http_status :success
    end
  end

#  describe 'POST /projects' do
#    it 'creates a project' do
#      project = FactoryGirl.build(:project)
#      project_attributes = FactoryGirl.attributes_for(project)
#
#      expect {
#        post '/projects', { title: project_attributes }
#      }.to change(Project, :count)
#    end
#
#    it 'redirect to the project show page'
#  end
end
