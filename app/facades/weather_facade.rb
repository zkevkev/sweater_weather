class WeatherFacade
  def current_weather(lat, lon)
    service = WeatherService.new
    current = service.get_current_weather(lat, lon)[:current]
    { 
      last_updated: current[:last_updated],
      feels_like: current[:feelslike_f],
      humidity: current[:humidity],
      uvi: current[:uv],
      visibility: current[:vis_miles],
      condition: current[:condition][:text],
      icon: current[:condition][:icon]
    }
  end
end
