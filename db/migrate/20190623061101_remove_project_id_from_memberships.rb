class RemoveProjectIdFromMemberships < ActiveRecord::Migration[5.1]
  def change
    remove_column :memberships, :project_id, :integer
  end
end
