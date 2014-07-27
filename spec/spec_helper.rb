def attributes_without_id(object)
  object.attributes.select { |k, v| k.to_s != 'id' }
end

def attributes_without(keys, object)
  object.attributes.keys.select { |k, v| 
    !keys.map { |key| key.to_s }.include?(k.to_s)
  }
end
