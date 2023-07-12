class CreateJoinTableComments < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :posts, table_name: :comments do |t|
      t.index [:user_id, :post_id]
      # t.index [:post_id, :user_id]
      t.timestamps
    end
    add_column :comments, :text, :string
    rename_column :comments, :user_id, :author_id
    add_foreign_key :comments, :users, column: :author_id
    add_foreign_key :comments, :posts
  end
end
