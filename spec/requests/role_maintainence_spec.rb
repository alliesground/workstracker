require 'rails_helper'

describe 'Role maintainence', type: :request do
  login

  it "assigns a role to the user and redirects to that user's profile page" do
    post roles_url(role: 'freelancer')

    expect(@current_user.roles.blank?).to be false
    expect(response).to redirect_to @current_user
  end

  context "when user already has an active role" do
    it "does not give access to the role selection page"
  end
end
