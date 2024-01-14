class Restaurant
  attr_reader :name,
              :address,
              :rating,
              :reviews

  def initialize(details)
    @name = details[:name]
    @address = details[:location][:display_address].first
    @rating = details[:rating]
    @reviews = details[:review_count]
  end
end
