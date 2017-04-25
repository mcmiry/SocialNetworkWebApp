class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.string :text
      t.string :image
      t.integer :like

      t.timestamps
    end
  end
end
