class Curator < ActiveRecord::Base
  validates_length_of :name, minimum: 3, maximum: 40

  validates_length_of :shortname, minimum: 3, maximum: 15
  validates_format_of :shortname, with: /\A[a-zA-Z][a-zA-Z0-9]*\z/i

  has_many :curatorships, dependent: :destroy
  has_many :clients
end
