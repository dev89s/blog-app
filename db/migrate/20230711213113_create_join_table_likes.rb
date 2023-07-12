class CreateJoinTableLikes < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :posts, table_name: :likes do |t|
      t.index [:user_id, :post_id]
      # t.index [:post_id, :user_id]

      t.timestamps
    end
    rename_column :likes, :user_id, :author_id
    add_foreign_key :likes, :users, column: :author_id
    add_foreign_key :likes, :posts
  end
end
