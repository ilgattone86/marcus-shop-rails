class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, comment: 'The name of the category'
      t.string :description, comment: 'The description of the category'
      t.datetime :deleted_at, comment: 'Soft deleted timestamp'

      t.timestamps
    end
  end
end
