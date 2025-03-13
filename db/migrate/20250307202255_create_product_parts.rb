class CreateProductParts < ActiveRecord::Migration[8.0]
  def change
    create_table :product_parts do |t|
      t.references :product, foreign_key: true, null: false, comment: 'The product which the part belongs to'
      t.references :part, foreign_key: true, null: false, comment: 'The part that the product has'

      t.timestamps
    end
  end
end
