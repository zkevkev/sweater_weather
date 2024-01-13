class WeatherService
  def conn
    Faraday.new(url: "http://api.weatherapi.com/v1/")
  end

  def current_weather(lat, lon)
    response = conn.get("current.json?key=#{Rails.application.credentials.weatherapi[:key]}&q=#{lat},#{lon}")
    hash = JSON.parse(response.body, symbolize_names: true)
    # weather = hash[:current]
    # { 
    #   last_updated: weather[:last_updated],
    #   feels_like: weather[:feelslike_f],
    #   humidity: weather[:humidity],
    #   uvi: weather[:uv],
    #   visibility: weather[:vis_miles],
    #   condition: weather[:condition][:text],
    #   icon: weather[:condition][:icon]
    # }
  end

  def forecast_daily(lat, lon)
    response = conn.get("forecast.json?key=#{Rails.application.credentials.weatherapi[:key]}&q=#{lat},#{lon}&days=5")
    hash = JSON.parse(response.body, symbolize_names: true)
    # weather = hash[:forecast][:forecastday]
    # weather.map do |day|
    #   { 
    #     date: day[:date],
    #     sunrise: day[:astro][:sunrise],
    #     sunset: day[:astro][:sunset],
    #     max_temp: day[:day][:maxtemp_f],
    #     min_temp: day[:day][:mintemp_f],
    #     condition: day[:day][:condition][:text],
    #     icon: day[:day][:condition][:icon]
    #   }
    # end
  end

  def forecast_hourly(lat, lon)
    response = conn.get("forecast.json?key=#{Rails.application.credentials.weatherapi[:key]}&q=#{lat},#{lon}&days=0")
    hash = JSON.parse(response.body, symbolize_names: true)
    # weather = hash[:forecast][:forecastday].first[:hour]
    # weather.map do |hour|
    #   { 
    #     time: hour[:time].split(' ')[1],
    #     temperature: hour[:temp_f],
    #     conditions: hour[:condition][:text],
    #     icon: hour[:condition][:icon]
    #   }
    # end    
  end
end
