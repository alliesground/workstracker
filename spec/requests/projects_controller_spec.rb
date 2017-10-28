require 'rails_helper'

describe 'Project management', type: :request do
  it 'returns the information for the requested project' do
    project = create(:project)
    get project_url(project)
    expect(response.body).to include "My first project"
  end
end
