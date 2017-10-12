FactoryGirl.define do
  factory :user do
    email 'test_user@example.com'
    provider 'github'
    uid 1
    password { Faker::Internet.password }
  end
end
