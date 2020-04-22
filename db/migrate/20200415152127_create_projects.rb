class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :img
      t.string :repo
      t.string :site

      t.timestamps
    end
  end
end
