require 'rails_helper'

feature "User role selection" do
  context "with authenticated user who has no roles selected" do
    scenario "selects the role" do
      valid_github_log_in
      expect(current_path).to eq choose_role_path
      click_button 'I want to work as a Freelancer'
      user = User.last
      expect(user.roles.blank?).to be false
      expect(current_path).to eq user_path user
      expect(page).to have_content 'freelancer'
    end
  end

  context "with authenticated user who already has roles selected" do
    scenario "cannot select roles" do
      user = create(:user)
      user.add_role 'client'

      valid_github_log_in
      expect(current_path).not_to eq choose_role_path
      expect(current_path).to eq user_path user
      expect(user.roles.blank?).to be false
    end
  end
end
