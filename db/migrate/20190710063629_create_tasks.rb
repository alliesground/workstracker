class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.references :list, foreign_key: true
      t.string :title
      t.text :description
      t.timestamps
    end

    add_column :tasks, :member_ids, :integer, array: true, default: []
  end
end
