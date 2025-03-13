class CreatePermissionsTable < ActiveRecord::Migration[8.0]
  def change
    create_table :permissions do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_table :permission_users do |t|
      t.references :user, foreign_key: true
      t.references :permission, foreign_key: true

      t.timestamps
    end
  end
end
