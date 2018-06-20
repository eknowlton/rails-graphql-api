class CreateRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :roles do |t|
      t.string :name, null: false

      t.timestamps
      t.datetime :deleted_at

      t.index :deleted_at
      t.index :name, unique: true
    end
  end
end
