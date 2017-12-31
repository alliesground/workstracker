require 'rails_helper'

describe Stakeholder do
  describe '.all_scoped_to' do
    it 'returns all users having roles scoped to the given resource, wrapped around stakeholder object' do
      user = create(:user, email: 'test@email.com')
      resource = create(:project, user: user)
      stakeholder = Stakeholder.new(user: user)

      stakeholder = Stakeholder.all_scoped_to(resource: resource).first
      expect(stakeholder.user).to eq user
    end
  end
end
