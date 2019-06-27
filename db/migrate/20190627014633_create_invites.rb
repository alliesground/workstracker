class CreateInvites < ActiveRecord::Migration[5.1]
  def change
    create_table :invites do |t|
      t.string :email
      t.string :token, index: true
      t.integer :recipient_id, index: true
      t.integer :sender_id, index: true
      t.references :invitable, polymorphic: true, index: true
      t.timestamps
    end

    add_foreign_key :invites, :users, column: :recipient_id
    add_foreign_key :invites, :users, column: :sender_id
  end
end
