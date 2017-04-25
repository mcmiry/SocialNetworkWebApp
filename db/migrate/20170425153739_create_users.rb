class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :email
      t.string :password
      t.string :nick
      t.string :profilepic
      t.integer :role

      t.timestamps
    end
  end
end
