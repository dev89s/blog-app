class CreateJoinTableComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :text
      t.timestamps
    end
    add_reference :comments, :author, foreign_key: { to_table: 'users' }, index: true
    add_reference :comments, :post, null: false, foreign_key: true, index: true
    add_index :comments, [:author_id, :post_id]
  end
end
