require 'rails_helper'

describe Stakeholder do
  describe '.all_scoped_to' do
    it 'returns all stakeholders scoped to the given resource' do
      user = create(:user, email: 'test@email.com')
      resource = create(:project, user: user)
      stakeholder = create(:stakeholder, resource_id: resource.id, user: user)

      expect(Stakeholder.all_scoped_to(resource: resource)).to include stakeholder
    end
  end
end
