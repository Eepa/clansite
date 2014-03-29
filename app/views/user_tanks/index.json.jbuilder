json.array!(@user_tanks) do |user_tank|
  json.extract! user_tank, :id, :user_id, :tank_id, :rating
  json.url user_tank_url(user_tank, format: :json)
end
