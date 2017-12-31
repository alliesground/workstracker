require 'rails_helper'

describe User do
  describe '#has_any_role_scoped_to?' do
    it 'returns true if a user is assigned a role scoped to the given resource' do
      user = create(:user)
      project = create(:project, user: user)

      expect(user.has_any_role_scoped_to?(resource: project)).to be true
    end
  end

  describe '#roles_scoped_to' do
    it 'returns'
  end
end
