FactoryGirl.define do
  factory :stakeholder do
    association :user
    resource_id 1
  end
end
