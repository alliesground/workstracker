class RemoveUniqueIndexOnUidAndProviderFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_index :users, column: [:uid, :provider]
  end
end
