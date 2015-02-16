json.array!(@salesmen) do |salesman|
  json.extract! salesman, :id, :name, :bank, :agency, :account, :operation
  json.url salesman_url(salesman, format: :json)
end
