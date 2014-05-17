class ClientShortnamesAreUnique < ActiveRecord::Migration
  def change
    add_index :clients, :shortname, unique: true
  end
end
