class CreateMemberships < ActiveRecord::Migration
  def up
    create_table :memberships, id: false do |t|
      t.integer  :user_id
      t.uuid     :client_id

      t.timestamps
    end

    execute "ALTER TABLE memberships ADD PRIMARY KEY (user_id, client_id);"
  end

  def down
    drop_table :memberships
  end
end
