json.array!(@prices) do |price|
  json.extract! price, :id, :course_id, :description, :payment_value, :payment_quantity
  json.url price_url(price, format: :json)
end
