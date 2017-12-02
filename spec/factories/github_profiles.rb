FactoryGirl.define do
  factory :github_profile do
    access_token ENV['TEST_USER_GITHUB_TOKEN']
    user nil
  end
end
