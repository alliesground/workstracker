require 'rails_helper'

describe 'InvitationsController', type: :request do
  let(:user) { create(:user, email: 'test_user@example.com') }
  let(:project) { create(:project, user: user) }

  before :each do 
    sign_in user
    get project_url(project) # to set the project session
  end

  describe 'GET /invitations/new' do
    it "provides user interface to send new invitation" do
      get '/invitations/new'
      expect(response).to have_http_status :success
    end
  end

  describe 'POST /invitations' do
    context 'with valid attributes' do
      before :each do
        post('/invitations', params: { invitation: attributes_for(:invitation) })
      end

      it "creates a new invitation" do
        expect(Invitation.count).to eq 1
      end

      it "redirects to the projects page for which invitation was sent" do
        expect(response).to redirect_to project
      end

      it "sends an invitation email" do
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end
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
end