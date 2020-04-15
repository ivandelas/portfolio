class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, default: 'admin'
      t.string :password_digest
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end