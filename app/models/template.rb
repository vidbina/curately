class Template
  include Mongoid::Document

  field :name

  validates_presence_of :name
  #validate :has_existing_curator

  embeds_many :elements

  def curator
    if self[:curator] && self[:curator][:id]
      Curator.find(self[:curator][:id])
    end
  end

  def curator=(resource)
    curator = Curator.find(resource[:id]) if resource.is_a? Hash
    self[:curator] = (({ id: resource.id, name: resource.name } if resource) or {})
    #p "curator is #{self[:curator]}"
  end

  private
  def has_existing_curator
    errors.add(
      :base, 'The curator does not yet exist'
    ) unless (self[:curator] && Curator.exists?(self[:curator][:id]))
  end
end
