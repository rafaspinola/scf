json.array!(@companies) do |company|
  json.extract! company, :id, :name, :cnpj, :county_subscription, :address, :neighborhood, :city, :state, :postal_code, :phone, :responsible_name, :responsible_email, :responsible_job_description
  json.url company_url(company, format: :json)
end
