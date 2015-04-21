json.array!(@movements) do |movement|
  json.extract! movement, :id, :due_date, :description, :value, :course_class_id, :account_id, :result_center_id, :bank_id
  json.url movement_url(movement, format: :json)
end
