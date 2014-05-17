json.array!(@accountants) do |accountant|
  json.extract! accountant, :id, :name
  json.url accountant_url(accountant, format: :json)
end
