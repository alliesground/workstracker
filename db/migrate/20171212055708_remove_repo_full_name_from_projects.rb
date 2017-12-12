class RemoveRepoFullNameFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :repo_full_name, :string
  end
end
