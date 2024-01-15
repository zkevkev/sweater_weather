class RoadtripSerializer
  def serialize_roadtrip(from, to)
    directions_facade = DirectionsFacade.new
    weather_facade = WeatherFacade.new
    geocoder = GeocodingFacade.new
    travel_time = directions_facade.travel_time(from, to)
    destination = to.split(',')
    lat_lon = geocoder.lat_lon(destination[0], destination[1])
    forecast = weather_facade.hourly_forecast(lat_lon[:lat], lat_lon[:lon])
    {
      "data": {
        "id": nil,
        "type": "road_trip",
        "attributes": {
          "start_city": from,
          "end_city": to,
          "travel_time": travel_time[:formatted],
          "weather_at_eta": {
            "datetime": travel_time[:arrival_time],
            "temperature": forecast[(travel_time[:arrival_time][0..1][:temperature])],
            "condition": forecast[(travel_time[:arrival_time][0..1])[:conditions]]
          }
        }
      }
    }.to_json
  end
end
