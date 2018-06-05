=begin
  require 'rails_helper'
  require 'helper'

  describe 'Users::RegistrationsController', type: :request do
    describe 'POST /users' do
      context 'when invited user registers' do
        let(:project) { create(:project) }
        let(:inviter) { create(:user) }
        let(:invitation) { create(:invitation, inviter: inviter, resource_id: project.id) }

        before :each do
          post(
            '/users',
            params: { user: attributes_for(:user, email: 'test@example.com'), token: invitation.token }
          )
        end

        it 'registers the user' do
          expect(User.last.email).to eq 'test@example.com'
        end

        it 'assigns the registered user a role scoped to a project instance' do
          expect(User.last.has_role?('client', project)).to be true
        end

        it 'resets token in invitations table to nil' do
          invitation.reload
          expect(invitation.token).to be nil
        end

        it "updates the recipient_id of the invitations table with the registered users id " do
          invitation.reload
          expect(invitation.recipient_id).to eq User.last.id
        end
      end
    end
  end
=end
