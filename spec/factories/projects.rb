FactoryGirl.define do
  factory :project do
    association :user
    title "test project"

    factory :invalid_project do
      title ""
    end
  end
end
