class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :keychain, null: false, foreign_key: true
      t.boolean :admin, false
      t.text :invite_status, null: false

      t.timestamps
    end
  end
end