class AddUserAndRepoNameToRepoTable < ActiveRecord::Migration[5.2]
  def change
    rename_column :repos, :url, :user_name
    add_column :repos, :repo_name, :string
  end
end
