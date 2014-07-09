class Curatorship < ActiveRecord::Base
  belongs_to :curator
  belongs_to :user

  validates_presence_of :curator
  validates_presence_of :user
end
