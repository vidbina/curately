class CreateCurators < ActiveRecord::Migration
  def change
    create_table :curators, id: :uuid do |t|
      t.string :name, { null: false }
      t.string :shortname, { null: false }

      t.timestamps
    end

    add_index :curators, :shortname, unique: true
  end
end
