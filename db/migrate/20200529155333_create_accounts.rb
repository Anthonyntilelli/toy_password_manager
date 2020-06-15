# frozen_string_literal: true

# Creates to store for passwords (plain text) and related login info
class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.text :name, null: false
      t.references :keychain, null: false, foreign_key: true
      t.text :url
      t.text :username
      t.text :password

      t.timestamps
    end
  end
end
