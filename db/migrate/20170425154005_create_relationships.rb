class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.references :user1, foreign_key: true
      t.references :user2, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
