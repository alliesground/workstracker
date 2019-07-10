class AddTimestampToLists < ActiveRecord::Migration[5.1]
  def change
    change_table(:lists) { |t| t.timestamps }
  end
end
