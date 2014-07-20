class Element
  include Mongoid::Document

  field :name

  validates_presence_of :name

  embedded_in :template
end
