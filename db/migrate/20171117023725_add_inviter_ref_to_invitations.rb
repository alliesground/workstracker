class AddInviterRefToInvitations < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :invitations, :users, column: :inviter_id, primary_key: :id
  end
end
