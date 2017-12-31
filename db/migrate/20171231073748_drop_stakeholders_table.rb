class DropStakeholdersTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :stakeholders
  end

  def down
    create_table :stakeholders do |t|
      t.integer :resource_id
    end
    add_reference :stakeholders, :user, foreign_key: true
    add_index :stakeholders, :resource_id
  end
end
