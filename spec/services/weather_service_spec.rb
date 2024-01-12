require 'rails_helper'

RSpec.describe WeatherService do
  before(:each) do
    @service = WeatherService.new
  end

  describe '#current_weather' do
    it 'returns ' do
      expect(@service.current_weather(48.8567, 2.3508)).to be_a(String)
      expect(@service.current_weather[:results]).to be_a(Array)

      # results = @service.current_weather[:results]
      # expect(results[0]).to be_a(Hash)
      # expect(results[0][:vote_average]).to be_a(Float)
    end
  end
end
