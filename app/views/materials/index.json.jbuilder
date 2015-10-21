json.array!(@materials) do |material|
  json.extract! material, :id, :description, :quantity, :unit_value, :movement_id
  json.url material_url(material, format: :json)
end
