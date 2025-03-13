class CreateRestrictions < ActiveRecord::Migration[8.0]
  def change
    create_table :restrictions do |t|
      t.references :dependent_option, foreign_key: { to_table: :part_options }, null: false, comment: 'The option that has some restrictions'
      t.references :blocked_option, foreign_key: { to_table: :part_options }, null: false, comment: 'The option that is blocked for the dependent option'

      t.timestamps
    end
  end
end
