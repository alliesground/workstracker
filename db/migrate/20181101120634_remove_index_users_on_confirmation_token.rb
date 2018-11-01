class RemoveIndexUsersOnConfirmationToken < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, column: :confirmation_token
  end
end
