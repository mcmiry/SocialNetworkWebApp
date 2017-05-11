class AddUserLikesToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :user_likes, :integer, array: true, default: [0]
  end
end
