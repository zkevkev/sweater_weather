class WeatherService
  def conn
    Faraday.new(url: "http://api.weatherapi.com/v1/")
  end

  def get_current_weather(lat, lon)
    response = conn.get("current.json?key=#{Rails.application.credentials.weatherapi[:key]}&q=#{lat},#{lon}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_forecast_daily(lat, lon)
    response = conn.get("forecast.json?key=#{Rails.application.credentials.weatherapi[:key]}&q=#{lat},#{lon}&days=5")
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_forecast_hourly(lat, lon)
    response = conn.get("forecast.json?key=#{Rails.application.credentials.weatherapi[:key]}&q=#{lat},#{lon}&days=0")
    JSON.parse(response.body, symbolize_names: true)
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
