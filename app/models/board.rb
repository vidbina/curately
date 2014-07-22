class Board
  include Mongoid::Document

  field :content

  validate :has_a_existing_curator
  validate :has_a_existing_client

  def elements
    (curator.template.elements if curator && curator.template) or []
  end

  def curator
    if self[:curator][:id]
      Curator.find(self[:curator][:id])
    end
  end

  def curator=(curator)
    self[:curator] = {
      id: curator.id,
      name: curator.name
    }
  end

  def client
    if self[:client][:id]
      Client.find(self[:client][:id])
    end
  end

  def client=(client)
    self[:client] = {
      id: client.id,
      name: client.name
    }
  end

  private
  def has_a_existing_curator
    errors.add(:base, 'The curator does not yet exist') unless Curator.exists? self[:curator][:id]
  end

  def has_a_existing_client
    errors.add(:base, 'The client does not yet exist') unless Client.exists? self[:client][:id]
  end
end
