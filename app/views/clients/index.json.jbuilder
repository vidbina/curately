json.array!(@clients) do |client|
  json.extract! client, :id, :name, :shortname, :data
  json.url client_url(client, format: :json)
end
