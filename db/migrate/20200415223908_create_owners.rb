class CreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :owners do |t|
      t.string :name
      t.string :email
      t.string :github
      t.string :linkedin
      t.text :about

      t.timestamps
    end
  end
end
