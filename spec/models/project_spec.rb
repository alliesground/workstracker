require 'rails_helper'

describe Project, type: :model do
  let(:owner) { create(:user, email: 'texas@email.com') }
  let(:project) { create(:project, user: owner) }

  describe '.to_join' do
    it 'returns a project for which an invitation was sent'
  end

  describe '#stakeholders' do
    it 'returns a collection of stakeholders of a project' do
      invited_user = create(:user)
      invited_stakeholder = create(:stakeholder, user: invited_user, resource_id: project.id)
      owner_stakeholder = Stakeholder.find_by(user: owner)
      expect(project.stakeholders).to eq([owner_stakeholder, invited_stakeholder])
    end
  end
end
