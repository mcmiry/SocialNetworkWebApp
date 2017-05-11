class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :from_user, foreign_key: true
      t.references :to_user, foreign_key: true
      t.string :subject
      t.string :text
      t.string :status

      t.timestamps
    end
  end
end
