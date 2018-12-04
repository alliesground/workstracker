class RemoveNameFromMemberships < ActiveRecord::Migration[5.1]
  def change
    remove_column :memberships, :name, :integer
  end
end
