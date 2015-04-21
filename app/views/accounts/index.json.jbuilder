json.array!(@accounts) do |account|
  json.extract! account, :id, :description, :top_account_id
  json.url account_url(account, format: :json)
end
