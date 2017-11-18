class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.string :recipient_name
      t.string :recipient_email
      t.string :recipient_role
      t.string :message
      t.string :token
    end
    add_index :invitations, :token
  end
end
