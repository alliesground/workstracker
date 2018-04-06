FactoryGirl.define do
  factory :project do
    association :user
    title Faker::Lorem.sentence

    after(:create) do |project|
      project.user.add_role('owner', project)
    end

    factory :invalid_project do
      title ""
    end
  end
end
