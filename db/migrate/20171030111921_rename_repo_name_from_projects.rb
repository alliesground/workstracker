class RenameRepoNameFromProjects < ActiveRecord::Migration[5.1]
  change_table :projects do |t|
    t.rename :repo_name, :repo_full_name
  end
end
