class Update
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  validate :has_some_data
  validate :only_has_known_fields

  field :timestamp

  embedded_in :board

  before_save :ensure_elements_are_stored
  before_save :set_time

  private
  def has_some_data
    errors.add(
      :base, 'At least one expected element needs to be set'
    ) if valid_elements.select{ |el| !self[el.name.to_sym].nil? }.empty?
  end

  def only_has_known_fields
    attributes_without(['_id', 'elements', 'timestamp'], self).each { |k|
      errors.add(
        :base, 
        "#{k} is not a valid element"
      ) unless valid_elements.map{ |element| element.name }.include? k.to_s
    }
  end

  def ensure_elements_are_stored
    set_elements unless self[:elements]
  end

  def set_elements
    #self[:elements] = board.elements
  end

  def set_time
    self[:timestamp] = Time.now.strftime('%Y%m%d%H%M%S%L')
  end

  def valid_elements
    (board.elements if board) or []
  end
end
