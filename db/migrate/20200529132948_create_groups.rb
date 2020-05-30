class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.text :name, null: false
      t.boolean :personal, null: false

      t.timestamps
    end
  end
end
