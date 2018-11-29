class ChangeMembershipsTypeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :memberships, :type, :name
  end
end
