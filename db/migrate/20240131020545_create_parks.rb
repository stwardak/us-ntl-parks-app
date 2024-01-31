class CreateParks < ActiveRecord::Migration[7.0]
  def change
    create_table :parks do |t|
      t.string :fullName
      t.text :description
      t.string :designation
      t.text :directionsInfo
      t.string :directionsUrl
      t.string :latLong
      t.string :latitude
      t.string :longitude
      t.string :name
      t.string :parkCode
      t.float :relevanceScore
      t.string :states
      t.string :url
      t.text :weatherInfo

      t.timestamps
    end
  end
end
