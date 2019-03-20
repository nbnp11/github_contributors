class CreateContributors < ActiveRecord::Migration[5.2]
  def change
    create_table :contributors do |t|
      t.references :repo, foreign_key: true
      t.string :login
      t.integer :place
      t.timestamps
    end
  end
end
