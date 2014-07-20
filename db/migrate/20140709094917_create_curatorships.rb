class CreateCuratorships < ActiveRecord::Migration
  def up
    create_table :curatorships, id: false do |t|
      t.integer :user_id
      t.uuid :curator_id

      t.timestamps
    end

    execute "ALTER TABLE curatorships ADD PRIMARY KEY (user_id, curator_id);"
  end

  def down
    drop_table :curatorships
  end
end
