FactoryGirl.define do
  factory :project do
    association :user
    title "test project"
    repo_full_name "#{ENV['TEST_USER']}/test-project"

    factory :invalid_project do
      title ""
    end
  end
end
