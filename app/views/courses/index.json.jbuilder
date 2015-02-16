json.array!(@courses) do |course|
  json.extract! course, :id, :name, :code, :price6, :price5, :price4, :price3, :price2, :price
  json.url course_url(course, format: :json)
end
