def attributes_without(keys, object)
  object.attributes.keys.select { |k, v| 
    !keys.map { |key| key.to_s }.include?(k.to_s)
  }
end
