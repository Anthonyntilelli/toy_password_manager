class CreateKeychains < ActiveRecord::Migration[6.0]
  def change
    create_table :keychains do |t|
      t.text :name, null: false

      t.timestamps
    end
  end
end
