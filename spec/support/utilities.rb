def valid_github_log_in
  visit root_path
  within(:css, "#top-header") do
    click_link 'Sign in with Github'
  end
end
