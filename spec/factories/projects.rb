FactoryGirl.define do
  factory :project do
    association :user
    title 'project title'

    after(:create) do |project|
      project.user.add_role('owner', project)
    end

    factory :invalid_project do
      title ""
    end
  end
end
