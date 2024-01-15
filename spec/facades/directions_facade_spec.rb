require 'rails_helper'

RSpec.describe DirectionsFacade do
  before(:each) do
    @facade = DirectionsFacade.new
  end

  describe '#travel_time' do
    it 'returns the total travel time for a trip (formatted and unformatted)' do
      response = @facade.travel_time('Cincinatti,OH', 'Chicago,IL')
      expect(response).to be_a(Hash)
      expect(response[:arrival_time]).to be_a(String)
      expect(response[:formatted]).to be_a(String)
      # expect(response[:unformatted]).to be_a(Hash)
      # expect(response[:unformatted][:hours]).to be_a(Integer)
      # expect(response[:unformatted][:mins]).to be_a(Integer)
    end
  end
end
