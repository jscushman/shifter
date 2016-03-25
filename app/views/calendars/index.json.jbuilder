json.array!(@calendars) do |calendar|
  json.extract! calendar, :id, :title, :description, :max_simultaneous
  json.url calendar_url(calendar, format: :json)
end
