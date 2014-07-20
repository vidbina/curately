class Curatorship < ActiveRecord::Base
  self.primary_keys = :user_id, :curator_id

  belongs_to :curator
  belongs_to :user

  validates_presence_of :curator
  validates_presence_of :user
end
