class CreateTodo < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.boolean :completed, default: false
      t.references :task, foreign_key: true
    end
  end
end
