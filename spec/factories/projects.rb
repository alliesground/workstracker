FactoryGirl.define do
  factory :project do
    title "My first project"

    factory :invalid_project do
      title ""
    end
  end
end
