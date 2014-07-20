class GiveCuratorsATemplateId < ActiveRecord::Migration
  def change
    add_column :curators, :template_id, :binary, limit: 12.bytes, default: nil
  end
end
