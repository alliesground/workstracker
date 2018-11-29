class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true
      t.integer :type

      t.timestamps
    end

    add_index :memberships, [:user_id, :project_id], unique: true
  end
end
