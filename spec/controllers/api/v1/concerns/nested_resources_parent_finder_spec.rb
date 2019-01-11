require 'rails_helper'
require 'api_helper'

RSpec.configure do |c|
  c.infer_base_class_for_anonymous_controllers = false
end

module Api::V1
  RSpec.describe Concerns::NestedResourcesParentFinder, type: :controller do
    controller do
      include Concerns::NestedResourcesParentFinder

      parent_resources :project

      def fake_members
        render json: parent_object.members
      end
    end

    let(:user) { create(:user) }
    let(:project) { create(:project) }

    before do
      routes.draw { get 'fake_members/:project_id' => 'anonymous#fake_members' }
      create(:membership, user: create(:user), project: project)
    end

    it 'renders json representation for project members' do
      get :fake_members, params: { project_id: project.id }

      members_response = json_response
      expect(members_response[:data].size).to eq 1
    end
  end
end
