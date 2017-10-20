FactoryGirl.define do
  factory :project_form do
    project_title "My first test project with a client"
    repo_name "My first test repository"

    factory :invalid_project_form do
      project_title ""
      repo_name ""
    end
  end
end
