class Curatorship < ActiveRecord::Base
  belongs_to :accountant
  belongs_to :user

  validates_presence_of :accountant
  validates_presence_of :user
end
