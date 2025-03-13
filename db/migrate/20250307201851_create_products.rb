class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true, null: false, comment: 'The category of the product'

      t.string :name, null: false, comment: 'The name of the product'
      t.string :description, comment: 'The description of the product'
      t.datetime :deleted_at, comment: 'Soft deleted timestamp'

      t.timestamps
    end
  end
end
