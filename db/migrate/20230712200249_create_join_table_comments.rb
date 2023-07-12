class CreateJoinTableComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :text
      t.timestamps
    end
    add_reference :comments, :author, foreign_key: { to_table: 'users' }, index: true
    add_reference :comments, :post, null: false, foreign_key: true, index: true
    # rename_column :comments, :user_id, :author_id
    # add_foreign_key :comments, :users, column: :author_id
    # add_foreign_key :comments, :posts
  end
end
