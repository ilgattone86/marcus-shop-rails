class CreateParts < ActiveRecord::Migration[8.0]
  def change
    create_table :parts do |t|
      t.string :name, null: false, comment: 'The name of the part'
      t.datetime :deleted_at, comment: 'Soft deleted timestamp'

      t.timestamps
    end
  end
end
