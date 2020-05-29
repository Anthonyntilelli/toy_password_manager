class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.text :email, null: false
      t.string :password_digest, null: false
      t.string :reset_token_digest

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
