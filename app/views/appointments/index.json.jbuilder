json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :created, :starts, :days, :note, :calendar_id, :person_id
  json.url appointment_url(appointment, format: :json)
end
