json.array!(@course_classes) do |course_class|
  json.extract! course_class, :id, :course_id, :city, :address, :start_time, :end_time
  json.url course_class_url(course_class, format: :json)
end
