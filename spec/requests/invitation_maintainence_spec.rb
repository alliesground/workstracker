require 'rails_helper'

describe 'Invitation maintainence', type: :request do
  login

  let(:project) { create(:project, user: @current_user) }

  before :each do
    project_decorator = double(
      'project_decorator',
      { 
        id: project.id,
        title: project.title
      }
    )

    allow(project).to receive(:decorate).and_return(project_decorator)

    allow(project_decorator).
      to receive(:repository_clone_url).
      and_return('hello world')
    
    allow(Project).to receive(:find).and_return(project)

    get project_url(project)
  end

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
