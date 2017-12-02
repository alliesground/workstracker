require 'rails_helper'

describe 'GithubAuthentications', type: :request do

  describe 'GET /sign_in_with_github' do
    it 'provides the interface for github login link' do
      get '/sign_in_with_github'
      expect(response).to have_http_status :success
      expect(response.body).to include "Sign in with Github"
    end
  end

  describe 'GET /sign_in_with_github/:token' do
    let(:user) { create(:user) }

    it 'provides github login link for invited users' do
      invitation = create(:invitation, inviter_id: user.id)

      get "/sign_in_with_github/#{invitation.token}"
      expect(response.body).to include "Sign in with Github"
    end

    it 'redirects to expired token page for invalid token' do
      get "/sign_in_with_github/123gb"
      expect(response).to redirect_to '/expired_token'
    end

    it 'sets invitation session' do
      invitation = create(:invitation, inviter_id: user.id)

      get "/sign_in_with_github/#{invitation.token}"
      expect(session[:invitation_id]).to eq invitation.id
    end
  end
end

