FactoryGirl.define do
  factory :user do
    email 'samy-limbu@gmail.com'
    provider 'github'
    uid 1
    password { Faker::Internet.password }

    after(:build) do |user|
      user.github_profile = build(:github_profile)
    end
  end
end
