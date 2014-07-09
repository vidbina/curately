class Membership < ActiveRecord::Base
  belongs_to :client
  belongs_to :user

  validates_presence_of :client
  validates_presence_of :user
end
