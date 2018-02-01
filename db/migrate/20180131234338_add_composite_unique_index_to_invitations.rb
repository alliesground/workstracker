class AddCompositeUniqueIndexToInvitations < ActiveRecord::Migration[5.1]
  def change
    add_index :invitations, [:recipient_email, :resource_id], unique: true
  end
end
