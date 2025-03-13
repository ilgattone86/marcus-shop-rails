class CreatePartOptions < ActiveRecord::Migration[8.0]
  def change
    create_table :part_options do |t|
      t.references :part, foreign_key: true, null: false, comment: 'The part that the option belongs to'

      t.string :name, null: false, comment: 'The name of the option'
      t.decimal :price, precision: 8, scale: 2, null: false, default: 0.0, comment: 'The price of the option'
      t.datetime :deleted_at, comment: 'Soft deleted timestamp'

      t.timestamps
    end
  end
end
