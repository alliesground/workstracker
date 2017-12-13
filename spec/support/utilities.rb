def valid_sign_in(user)
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'wildhorses'
  click_button 'Log in'
end

def sign_out
  visit root_path
  within(:css, "#top-header") do
    click_link 'Sign out'
  end
end
