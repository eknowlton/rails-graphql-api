class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.string :ability
      t.references :permissable, polymorphic: true, index: true, null: false

      t.timestamps
      t.datetime :deleted_at

      t.index :deleted_at
      t.index [:permissable_id, :permissable_type, :ability],
        unique: true,
        name: "index_permissions_on_permissable_and_ability"
    end
  end
end
