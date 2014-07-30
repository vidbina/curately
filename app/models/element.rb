class Element
  include Mongoid::Document

  field :name
  field :key

  validates_presence_of :name

  embedded_in :template

  before_save :set_key
  before_validation :set_key

  def key
    set_key unless self[:key]
    self[:key]
  end

  private
  def set_key
    self[:key] = name.underscore.split.join('_').gsub(/[\W]+/, '') if name
  end
end
