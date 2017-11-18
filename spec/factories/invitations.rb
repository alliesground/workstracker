FactoryGirl.define do
  factory :invitation do
    association :user
    recipient_name { Faker::Name.name }
    recipient_email { Faker::Internet.email }
    recipient_role 'client'
    message { Faker::Lorem.paragraph }
    resource_id 1

    factory :invalid_invitation do
      recipient_email ''
    end
  end
end
