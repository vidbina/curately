class AddAdministratorRole < ActiveRecord::Migration
  def change
    add_column :memberships, :is_admin, :boolean, default: false
    add_column :curatorships, :is_admin, :boolean, default: false
  end
end
