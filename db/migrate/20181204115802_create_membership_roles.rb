class CreateMembershipRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :membership_roles do |t|
      t.integer :name
      t.references :membership, foreign_key: true

      t.timestamps
    end
  end
end
