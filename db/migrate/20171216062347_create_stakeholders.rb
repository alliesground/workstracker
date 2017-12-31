class CreateStakeholders < ActiveRecord::Migration[5.1]
  def change
    create_table :stakeholders do |t|
      t.integer :resource_id
    end
    add_index :stakeholders, :resource_id
  end
end
