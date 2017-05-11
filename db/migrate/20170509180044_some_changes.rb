class SomeChanges < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :like
    remove_column :posts, :user_likes
    drop_table :shares
  end
end
