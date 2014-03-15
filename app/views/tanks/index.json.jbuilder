json.array!(@tanks) do |tank|
  json.extract! tank, :id, :name, :description, :country_id
  json.url tank_url(tank, format: :json)
end
