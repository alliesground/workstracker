require 'rails_helper'

describe 'Invitation maintainence', type: :request do
  login

  it "provides user interface to send new invitation" do
    get '/invitations/new'
    expect(response).to have_http_status :success
  end

  context 'with valid attributes' do
    before :each do
      post('/invitations', params: { invitation: attributes_for(:invitation) })
    end

    it "creates a new invitation" do
      expect(Invitation.count).to eq 1
    end

    it "redirects to the projects page for which invitation was sent"
  end

  context 'with invalid attributes' do
    before :each do
      post('/invitations', params: { invitation: attributes_for(:invalid_invitation) })
    end
    it "does not create an invitation in the database" do
      expect(Invitation.count).to eq 0
      expect(response.body).to include("Invite People")
    end
  end
end
