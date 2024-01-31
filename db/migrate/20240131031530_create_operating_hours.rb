class CreateOperatingHours < ActiveRecord::Migration[7.0]
  def change
    create_table :operating_hours do |t|
      t.string :name
      t.text :description
      t.text :standardHours
      t.text :exceptions
      t.references :park, null: false, foreign_key: true

      t.timestamps
    end
  end
end
