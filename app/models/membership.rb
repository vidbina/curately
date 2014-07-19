class Membership < ActiveRecord::Base
  self.primary_keys = :user_id, :client_id

  belongs_to :client
  belongs_to :user

  validates_presence_of :client
  validates_presence_of :user
end
