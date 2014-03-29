json.array!(@player_tanks) do |player_tank|
  json.extract! player_tank, :id, :player_id, :tank_id, :rating
  json.url player_tank_url(player_tank, format: :json)
end
