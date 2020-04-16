class AddLocationToOwner < ActiveRecord::Migration[6.0]
  def change
    add_column :owners, :location, :string
  end
end
