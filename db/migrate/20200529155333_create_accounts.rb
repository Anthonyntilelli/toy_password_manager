class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.text :name, null: false
      t.references :group, null: false, foreign_key: true
      t.text :url
      t.text :username
      t.text :password

      t.timestamps
    end
  end
end
