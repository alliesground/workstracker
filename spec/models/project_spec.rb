require 'rails_helper'

describe Project, type: :model do
  before :each do
    @project = create(:project)
  end

  describe '.to_join' do
    it 'returns a project for which an invitation was sent'
  end
end
