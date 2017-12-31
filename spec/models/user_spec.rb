require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  describe '#has_any_role_scoped_to?' do
    it 'returns true if a user is assigned a role scoped to the given resource' do
      project = create(:project, user: user)

      expect(user.has_any_role_scoped_to?(resource: project)).to be true
    end
  end

  describe '#roles_scoped_to' do
    it 'returns all the roles of a user that is scoped to a resource' do
      invited_user = create(:user)
      project = create(:project)
      invited_user.add_role('client', project)
      invited_user.add_role('collaborator', project)

      expect(
        invited_user.roles_scoped_to(resource: project).size
      ).to eq 2
    end
  end
end
