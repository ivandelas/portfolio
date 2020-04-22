class AddOwnerToProjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :projects, :owner, foreign_key: true
  end
end
