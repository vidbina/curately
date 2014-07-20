class LinkClientToCurator < ActiveRecord::Migration
  def change
    add_column :clients, :curator_id, :uuid
  end
end
