json.array!(@clans) do |clan|
  json.extract! clan, :id, :name, :description
  json.url clan_url(clan, format: :json)
end
