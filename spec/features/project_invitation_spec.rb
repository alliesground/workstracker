=begin
  require 'rails_helper'

  feature 'Project invitation' do
    given(:user) { create(:user, password: 'wildhorses') }
    given(:invited_user) { {name: 'invited user', email: 'invited_user@example.com'} }
    given(:project) { create(:project, user: user) }

    background do
      valid_sign_in(user)
    end

    scenario "sends invitation via email to join a project through registration" do
      visit project_path(project)

      find("a[href='/invitations/new']").click
      fill_in 'Recipient Name', with: invited_user[:name]
      fill_in 'Recipient Email', with: invited_user[:email]
      fill_in 'Message', with: "Please join this project"
      select('client', from: 'Recipient role')

      click_button('Send')
      sign_out
      expect_invitation_to_be_sent_to(invited_user[:email])

      invited_user_follows_the_email_link_to_register(invited_user[:email])
      register_invited_user

      expect(page).to have_content project.title
      expect(page).to have_content invited_user[:email]
    end

    def register_invited_user
      within(:css, 'div.form-inputs div.user_password') do
        fill_in 'Password', with: 'wildhorses'
      end

      within(:css, 'div.form-inputs div.user_password_confirmation') do
        fill_in 'Password confirmation', with: 'wildhorses'
      end

      click_button 'Sign up'
    end

    def expect_invitation_to_be_sent_to(email)
      open_email(email)
      expect(current_email).to have_link 'Join'
    end

    def invited_user_follows_the_email_link_to_register(email)
      open_email(email)
      current_email.click_link 'Join'
    end
  end
=end
