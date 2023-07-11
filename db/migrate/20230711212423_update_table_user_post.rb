class UpdateTableUserPost < ActiveRecord::Migration[7.0]
  def change
    rename_table :posts_users, :comments
    rename_column :comments, :user_id, :author_id
    add_foreign_key :comments, :users, column: :author_id
    add_foreign_key :comments, :posts
  end
end
