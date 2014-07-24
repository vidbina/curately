class Board
  VERSION_ID = :_timestamp

  include Mongoid::Document

  field :content

  validate :has_a_existing_curator
  validate :has_a_existing_client
  validate :has_permitted_elements

  def elements
    (curator.template.elements if curator && curator.template) or []
  end

  def history
    self[:content] or {}
  end

  def content
    (self[:content][-1] if self[:content]) or {}
  end

  def content=(details)
    return unless details

    # NOTE: kind of obsolete as we already have a validation
    data = details.select { |k, v| 
      elements.map { |e| e.name }.include? k.to_s
    }.merge(VERSION_ID => get_stamp)

    if self[:content] != nil
      self[:content] << data # NOTE: could still crash if content isn't an array
    else
      self[:content] = [data]
    end
  end

  def curator
    if self[:curator] && self[:curator][:id]
      Curator.find(self[:curator][:id])
    end
  end

  def curator=(curator)
    #p "setting for curator #{curator}"
    curator = Curator.find(curator[:id]) if curator.is_a? Hash
    self[:curator] = {
      id: curator.id,
      name: curator.name
    } unless curator.nil?
  end

  def client
    if self[:client] && self[:client][:id]
      Client.find(self[:client][:id])
    end
  end

  def client=(client)
    client = Client.find(client[:id]) if client.is_a? Hash
    self[:client] = {
      id: client.id,
      name: client.name
    } unless client.nil?
  end

  private
  def elements
    (curator.template.elements if curator && curator.template) or []
  end

  def element_names
    elements.map { |el| el.name } << VERSION_ID
  end

  alias :els :elements

  def valid_element? (field)
    !curator.template.elements.where(name: field.to_s).empty?
  end

  def has_a_existing_curator
    errors.add(
      :base, 'The curator does not yet exist'
    ) unless (self[:curator] && Curator.exists?(self[:curator][:id]))
  end

  def has_a_existing_client
    errors.add(
      :base, 'The client does not yet exist'
    ) unless (self[:client] && Client.exists?(self[:client][:id]))
  end

  def has_permitted_elements
    content.keys.each do |el|
      next if el.to_sym == VERSION_ID.to_sym
      errors.add(
        :base, "#{el} is not a valid element"
      ) if !element_names.include? el.to_s
    end
  end

  def get_stamp
    Time.now.strftime('%Y%m%d%H%M%S%L')
  end
end
