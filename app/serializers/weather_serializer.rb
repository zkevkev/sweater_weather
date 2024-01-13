class WeatherSerializer
  def serialize_weather(lat, lon)
    facade = WeatherFacade.new
    {
      "data": {
        "id": nil,
        "type": "forecast",
        "attributes": {
          "current_weather": facade.current_weather(lat, lon),
          "daily_weather": facade.daily_forecast(lat, lon),
          "hourly_weather": facade.hourly_forecast(lat, lon)
        }
      }
    }.to_json
  end
end
