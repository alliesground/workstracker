require 'rails_helper'

describe Project, type: :model do
  let(:owner) { create(:user, email: 'texas@email.com') }
  let(:project) { create(:project, user: owner) }

  describe '.to_join' do
    it 'returns a project for which an invitation was sent'
  end
end
