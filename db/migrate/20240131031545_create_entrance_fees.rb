class CreateEntranceFees < ActiveRecord::Migration[7.0]
  def change
    create_table :entrance_fees do |t|
      t.string :cost
      t.text :description
      t.string :title
      t.references :park, null: false, foreign_key: true

      t.timestamps
    end
  end
end
