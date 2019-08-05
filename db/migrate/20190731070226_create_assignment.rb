class CreateAssignment < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true
      t.timestamps
    end
  end
end