class WeatherFacade
  def current_weather(lat, lon)
    service = WeatherService.new
    weather = service.get_current_weather(lat, lon)[:current]
    { 
      last_updated: weather[:last_updated],
      temperature: weather[:temp_f],
      feels_like: weather[:feelslike_f],
      humidity: weather[:humidity],
      uvi: weather[:uv],
      visibility: weather[:vis_miles],
      condition: weather[:condition][:text],
      icon: weather[:condition][:icon]
    }
  end

  def daily_forecast(lat, lon)
    service = WeatherService.new
    weather = service.get_forecast_daily(lat, lon)[:forecast][:forecastday]
    weather.map do |day|
      { 
        date: day[:date],
        sunrise: day[:astro][:sunrise],
        sunset: day[:astro][:sunset],
        max_temp: day[:day][:maxtemp_f],
        min_temp: day[:day][:mintemp_f],
        condition: day[:day][:condition][:text],
        icon: day[:day][:condition][:icon]
      }
    end
  end
end
