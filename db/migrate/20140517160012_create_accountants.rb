class CreateAccountants < ActiveRecord::Migration
  def change
    create_table :accountants, id: :uuid do |t|
      t.string :name, { null: false }
      t.string :shortname, { null: false }

      t.timestamps
    end

    add_index :accountants, :shortname, unique: true
  end
end
