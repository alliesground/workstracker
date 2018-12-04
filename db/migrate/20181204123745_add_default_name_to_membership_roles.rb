class AddDefaultNameToMembershipRoles < ActiveRecord::Migration[5.1]
  def up
    change_column :membership_roles, :name, :integer, default: 0, null: false
    change_column_null :membership_roles, :name, false
  end

  def down
    change_column :membership_roles, :name, :integer, default: nil
    change_column_null :membership_roles, :name, true
  end
end
