json.array!(@participants) do |participant|
  json.extract! participant, :id, :name, :cpf, :birthday, :marital_state, :address, :neighborhood, :city, :state, :postal_code, :phone, :cellphone, :email, :profession, :job_description
  json.url participant_url(participant, format: :json)
end
