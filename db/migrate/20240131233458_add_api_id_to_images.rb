class AddApiIdToImages < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :api_id, :string
  end
end
