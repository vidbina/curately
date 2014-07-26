def attributes_without_id(object)
  object.attributes.select { |k, v| k.to_s != 'id' }
end
