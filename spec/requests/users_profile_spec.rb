require 'rails_helper'

describe 'Users Profile', type: :request do
  login

  describe 'GET /users/profiles/:id' do
    it 'displays the users profile page' do
      get users_profile_url(@current_user.id)
      expect(response).to be_success
      expect(response.body).to include @current_user.email
    end
  end
end
