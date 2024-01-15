class DirectionsFacade
  def travel_time(from, to)
    service = DirectionsService.new
    hash = service.get_directions('Cincinatti,OH', 'Chicago,IL')
    total_minutes = hash[:route][:time] / 60
    hours = total_minutes / 60
    minutes = total_minutes % 60
    {
      formatted: hash[:route][:formattedTime],
      unformatted: {
        hours: hours,
        mins: minutes
      }
    }
  end
end
