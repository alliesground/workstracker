class AddRecipientIdToInvitations < ActiveRecord::Migration[5.1]
  def change
    add_column :invitations, :recipient_id, :integer
    add_index :invitations, :recipient_id
  end
end
