class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :postalCode
      t.string :city
      t.string :stateCode
      t.string :countryCode
      t.string :provinceTerritoryCode
      t.string :line1
      t.string :line2
      t.string :line3
      t.string :addressType
      t.references :park, null: false, foreign_key: true

      t.timestamps
    end
  end
end
