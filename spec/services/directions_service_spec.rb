require 'rails_helper'

RSpec.describe DirectionsService do
  before(:each) do
    @service = DirectionsService.new
  end

  describe '#conn' do
    it 'establishes a connection with mapquest directions API' do
      expect(@service.conn).to be_a(Faraday::Connection)
    end
  end

  describe '#get_directions' do
    it 'returns route info between two locations' do
      response = @service.get_directions('Cincinatti,OH', 'Chicago,IL')
      travel_time = response[:route][:formattedTime]
      expect(travel_time).to be_a(String)
    end
  end
end
