class RemoveConfirmationFieldsFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :unconfirmed_email, :string
    remove_column :users, :confirmation_sent_at, :datetime
    remove_column :users, :confirmed_at, :datetime
    remove_column :users, :confirmation_token, :string
  end
end
