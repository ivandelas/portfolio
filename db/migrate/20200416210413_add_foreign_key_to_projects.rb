class AddForeignKeyToProjects < ActiveRecord::Migration[6.0]
  def change
    change_column :projects, :owner_id, :bigint, foreign_key: true
  end
end
