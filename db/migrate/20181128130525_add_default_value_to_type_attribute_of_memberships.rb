class AddDefaultValueToTypeAttributeOfMemberships < ActiveRecord::Migration[5.1]
  def up
    change_column :memberships, :type, :integer, default: 0
  end

  def down
    change_column :memberships, :type, :integer, default: nil
  end
end
