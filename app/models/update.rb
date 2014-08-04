class Update
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  validate :has_some_data
  validate :only_has_known_fields

  field :time, type: DateTime

  embedded_in :board

  before_save :ensure_elements_are_stored
  before_save :set_time

  def elements
    valid_elements.select{ |el| attributes.key? el.key }.map { |element|
      { element => self[element.key] }
    }.inject(&:merge)
  end

  def setup_element_methods
    valid_elements.map { |el| el.key }.each { |element|
      self.class.send(:define_method, element, ->{ self[element.to_sym] })
      #self.class.send(:define_method, "#{element}=", { |value| self[element.to_sym] }
    }
  end

  private
  def has_some_data
    errors.add(
      :base, 'At least one expected element needs to be set'
    ) if valid_elements.select{ |el| !self[el.key.to_sym].nil? }.empty?
  end

  def only_has_known_fields
    attributes_without(['_id', 'elements', 'time'], self).each { |k|
      errors.add(
        :base, 
        "#{k} is not a valid element"
      ) unless valid_elements.map{ |element| element.key }.include? k.to_s
    }
  end

  def ensure_elements_are_stored
    set_elements unless self[:elements]
  end

  def set_elements
    #self[:elements] = board.elements
  end

  def set_time
    self[:time] = DateTime.now # Time.now.strftime('%Y%m%d%H%M%S%L')
  end

  def valid_elements
    (board.elements if board) or []
  end
  
  def attributes_without(keys, object)
    object.attributes.keys.select { |k, v| 
      !keys.map { |key| key.to_s }.include?(k.to_s)
    }
  end
end
