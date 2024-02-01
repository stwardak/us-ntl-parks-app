class RemoveApiIdFromImages < ActiveRecord::Migration[7.0]
  def change
    remove_column :images, :api_id, :string
  end
end
