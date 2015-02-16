json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :id, :participant_id, :course_class_id, :company_id, :salesman_id, :amount, :amount
  json.url subscription_url(subscription, format: :json)
end
