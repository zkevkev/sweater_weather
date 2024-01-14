require 'rails_helper'

RSpec.describe MunchiesSerializer do
  before(:each) do
    @serializer = MunchiesSerializer.new
  end

  describe '#serialize_munchies' do
    it 'returns a nested hash of weather and restaurant data for a location' do
      response = @serializer.serialize_munchies(39.74001, -104.99202, 'italian')
      
    end
  end
end