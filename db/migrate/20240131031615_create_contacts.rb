class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.text :phoneNumbers
      t.text :emailAddresses
      t.references :park, null: false, foreign_key: true

      t.timestamps
    end
  end
end
