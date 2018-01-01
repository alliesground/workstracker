class AddStatusToInvitations < ActiveRecord::Migration[5.1]
  def change
    add_column :invitations, :status, :integer, default: 0
    add_index :invitations, :status
  end
end
