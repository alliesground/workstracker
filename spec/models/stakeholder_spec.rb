require 'rails_helper'

describe Stakeholder do
  describe '.all_scoped_to' do
    it 'returns all stakeholders having roles scoped to the given resource' do
      owner = create(:user, email: 'test1@email.com')
      stakeholder = create(:user, email: 'test2@email.com')
      resource = create(:project, user: owner)
      stakeholder.add_role('collaborator', resource)

      stakeholders = Stakeholder.all_scoped_to(resource: resource)

      expect(stakeholders.size).to eq(2)
    end

    it 'does not return a stakeholder who does not have roles scoped to the given resource' do
      user = create(:user, email: 'test1@email.com')
      resource = create(:project, user: user)

      user2 = create(:user, email: 'test2@email.com')
      other_resource = create(:project, user: user2)
      user.add_role('collaborator', other_resource)

      stakeholders = Stakeholder.all_scoped_to(resource: resource)
      expect(stakeholders.size).not_to eq(2)
    end
  end
end
