class AddInviterIdInvitations < ActiveRecord::Migration[5.1]
  def change
    add_column :invitations, :inviter_id, :integer
    add_index :invitations, :inviter_id
  end
end
