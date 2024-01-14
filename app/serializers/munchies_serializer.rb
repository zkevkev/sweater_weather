class MunchiesSerializer
  def serialize_munchies(city, state, cuisine)
    restaurant_facade = RestaurantFacade.new
    weather_facade = WeatherFacade.new
    geocoder = GeocodingFacade.new
    lat_lng = geocoder.lat_lon(city, state)
    {
      "data": {
        "id": nil,
        "type": "munchie",
        "attributes": {
          "destination_city": "#{city}, #{state}",
          "forecast": weather_facade.current_weather_short(lat_lng[:lat], lat_lng[:lon]),
          "restaurant": restaurant_facade.restaurant_search(lat_lng[:lat], lat_lng[:lon], cuisine)
        }
      }
    }.to_json
  end
end
