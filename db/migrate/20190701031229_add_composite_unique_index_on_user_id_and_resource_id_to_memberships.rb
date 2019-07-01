class AddCompositeUniqueIndexOnUserIdAndResourceIdToMemberships < ActiveRecord::Migration[5.1]
  def change
    add_index :memberships, [:user_id, :resource_id], unique: true
  end
end
