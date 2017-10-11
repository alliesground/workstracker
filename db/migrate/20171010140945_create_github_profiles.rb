class CreateGithubProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :github_profiles do |t|
      t.string :access_token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
