class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :shortname
      t.text :data

      t.timestamps
    end
  end
end
