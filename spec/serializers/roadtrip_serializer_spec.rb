require 'rails_helper'

RSpec.describe RoadtripSerializer do
  before(:each) do
    @serializer = RoadtripSerializer.new
  end

  describe '#serialize_roadtrip' do
    it 'returns a nested hash of roadtrip data' do
      response = @serializer.serialize_roadtrip('Cincinatti,OH', 'Chicago,IL')
    end
  end
end
