def attributes_without_id(object)
  object.attributes.select { |k, v| k.to_s != 'id' }
end

def attributes_without(keys, object)
  object.attributes.keys.select { |k, v| 
    !keys.map { |key| key.to_s }.include?(k.to_s)
  }
end

def basic_auth(user, password)
  ActionController::HttpAuthentication::Basic.encode_credentials user, password
end

def h(input)
  ERB::Util.html_escape(input)
end
