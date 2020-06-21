# frozen_string_literal: true

# Create user account in db
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.text :name, null: false
      t.text :email, null: false
      t.string :password_digest, null: false
      t.boolean :dummy_password, default: false

      t.timestamps
    end
  end
end
