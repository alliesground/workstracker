class AddUserRefToStakeholders < ActiveRecord::Migration[5.1]
  def change
    add_reference :stakeholders, :user, foreign_key: true
  end
end
