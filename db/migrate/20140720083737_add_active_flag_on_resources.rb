class AddActiveFlagOnResources < ActiveRecord::Migration
  def change
    add_column :curators, :is_active, :boolean, default: true
    add_column :clients,  :is_active, :boolean, default: true
  end
end
