class AddRoleToMemberships < ActiveRecord::Migration[5.1]
  def change
    add_column :memberships, :role, :integer, default: 0
  end
end
