class CreateJoinTableLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|

      t.timestamps
    end
    add_reference :likes, :author, foreign_key: { to_table: 'users' }, index: true
    add_reference :likes, :post, null: false, foreign_key: true, index: true
    add_index :likes, [:author_id, :post_id]
  end
end
