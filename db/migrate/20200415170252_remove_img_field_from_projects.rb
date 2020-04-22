class RemoveImgFieldFromProjects < ActiveRecord::Migration[6.0]
  def change
    remove_column :projects, :img
  end
end
