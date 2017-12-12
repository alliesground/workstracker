require 'rails_helper'

describe 'Users::ProfilesController', type: :request do
  let(:user) { create(:user, email: 'test_user@example.com') } 

  before :each do 
    sign_in user
  end

  describe 'GET /users/profiles/:id' do
    it 'displays the users profile page' do
      get users_profile_url(user.id)
      expect(response).to be_success
      expect(response.body).to include user.email
    end
  end
end
