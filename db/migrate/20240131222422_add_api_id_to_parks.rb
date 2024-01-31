class AddApiIdToParks < ActiveRecord::Migration[7.0]
  def change
    add_column :parks, :api_id, :string
  end
end
