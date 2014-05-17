class EnableUuidOsspExtension < ActiveRecord::Migration
  def up
    enable_extension :uuid_ossp
  end

  def down
    disable_extension :uuid_ossp
  end
end
