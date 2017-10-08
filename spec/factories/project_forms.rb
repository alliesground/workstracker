FactoryGirl.define do
  factory :project_form do
    project_title "My first project with a client"

    factory :invalid_project_form do
      project_title ""
    end
  end
end
