class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :from_user, foreign_key: true
      t.string :to_user
      t.string :references
      t.string :subject
      t.string :string
      t.string :text
      t.string :string
      t.string :status
      t.string :string

      t.timestamps
    end
  end
end
