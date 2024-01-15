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
          "start_city": from.split(',')[0],
          "end_city": to.split(',')[0],
          "travel_time": travel_time[:formatted],
          "weather_at_eta": {
            "datetime": travel_time[:arrival_time],
            "temperature": forecast[(travel_time[:arrival_time][0..1]).to_i][:temperature],
            "condition": forecast[(travel_time[:arrival_time][0..1]).to_i][:conditions]
          }
        }
      }
    }.to_json
  end
end
