FactoryGirl.define do
  factory :user do
    email 'samy-limbu@gmail.com'
    password { Faker::Internet.password }
  end
end
