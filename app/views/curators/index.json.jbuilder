json.array!(@curators) do |curator|
  json.extract! curator, :id, :name
  json.url curator_url(curator, format: :json)
end
