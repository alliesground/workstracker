require 'rails_helper'

describe Project, type: :model do
  let(:owner) { create(:user, email: 'texas@email.com') }
  let(:project) { create(:project, user: owner) }

  describe '.title_for' do
    let(:project) { create(:project) }

    it 'returns a project title' do
      expect(Project.title_for(id: project.id)).to eq 'test project'
    end
  end
end
