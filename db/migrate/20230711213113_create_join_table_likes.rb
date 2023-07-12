class CreateJoinTableLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|

      t.timestamps
    end
    add_reference :likes, :author, foreign_key: { to_table: 'users' }, index: true
    add_reference :likes, :post, null: false, foreign_key: true, index: true
    # rename_column :likes, :user_id, :author_id
    # add_foreign_key :likes, :users, column: :author_id
    # add_foreign_key :likes, :posts
  end
end
