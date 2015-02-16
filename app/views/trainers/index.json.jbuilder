json.array!(@trainers) do |trainer|
  json.extract! trainer, :id, :name, :bank, :agency, :account, :operation
  json.url trainer_url(trainer, format: :json)
end
