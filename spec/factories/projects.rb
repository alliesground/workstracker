FactoryGirl.define do
  factory :project do
    title 'project title'

    factory :invalid_project do
      title ""
    end
  end
end
