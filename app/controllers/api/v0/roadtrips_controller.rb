class Api::V0::RoadtripsController < ApplicationController
  def create
    data = JSON.parse(request.body.read)
    roadtrip_data = roadtrip_params(data)
    user = User.find_by(api_key: roadtrip_data[:api_key])

    if user
      render json: RoadtripSerializer.new.serialize_roadtrip(roadtrip_data[:origin], roadtrip_data[:destination])
    # elsif a field is left blank (move above)
    else
      render json: { errors: 'Invalid api key, please try again' }, status: :unprocessable_entity
    end
  end

  private

  def roadtrip_params(data)
    roadtrip_params = {
      origin: data['origin'],
      destination: data['destination'],
      api_key: data['api_key']
    }
  end
end
