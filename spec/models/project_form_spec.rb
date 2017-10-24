require 'rails_helper'

describe ProjectForm, type: :model do
  it { should validate_presence_of(:project_title) }
  it { should validate_presence_of(:repo_name) }

  describe "#save" do
    let(:current_user) { build(:user) }
    let(:project_form) { build(:project_form) }
    let(:invalid_project_form) { build(:invalid_project_form) }

    context "with valid attributes" do
      it "returns true" do
        allow(project_form).
          to receive(:create_github_repo).
          and_return({ name: "My first test repository" })

        expect(project_form.save(current_user: current_user)).to be true
      end
    end

    context "with invalid attributes" do
      it "returns false" do
        expect(invalid_project_form.save(current_user: current_user)).to be false
      end
    end

    context "when an exception is raised" do
      it "returns false" do
        allow(project_form).
          to receive(:create_github_repo).
          and_raise(Octokit::UnprocessableEntity)

        expect(project_form.save(current_user: current_user)).to be false
      end
    end
  end
end
