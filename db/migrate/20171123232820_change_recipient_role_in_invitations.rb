class ChangeRecipientRoleInInvitations < ActiveRecord::Migration[5.1]
  def change
    remove_column :invitations, :recipient_role, :string
    add_column :invitations, :recipient_role, :integer
  end
end
