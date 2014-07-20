class Template
  include Mongoid::Document

  field :name

  validates_presence_of :name

  embeds_many :elements
end
