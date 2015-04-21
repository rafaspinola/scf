json.array!(@result_centers) do |result_center|
  json.extract! result_center, :id, :name
  json.url result_center_url(result_center, format: :json)
end
