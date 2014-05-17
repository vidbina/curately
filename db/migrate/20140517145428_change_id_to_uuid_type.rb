class ChangeIdToUuidType < ActiveRecord::Migration
  def change
    drop_table :clients

    create_table :clients, id: :uuid do |t|
      t.string :name, { null: false }
      t.string :shortname, { null: false }
      t.text   :data

      t.timestamps
    end

    add_index :clients, :shortname, unique: true
  end
end
