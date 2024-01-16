class DirectionsFacade
  def travel_time(from, to)
    service = DirectionsService.new
    hash = service.get_directions(from, to)
    # total_minutes = hash[:route][:time] / 60
    # hours = total_minutes / 60
    # minutes = total_minutes % 60
    if hash[:route][:routeError]
      { error: 'Impossible' }
    else
      arrival_time = Time.now + hash[:route][:time]
      arrival_time = arrival_time.strftime('%H:%M:%S')
      {
        arrival_time: arrival_time,
        formatted: hash[:route][:formattedTime]
      }
    end
  end
end
