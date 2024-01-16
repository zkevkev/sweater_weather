class Api::V0::RoadtripsController < ApplicationController
  def create
    user = User.find_by(api_key: roadtrip_params[:api_key])
    if user
      roadtrip_info = RoadtripSerializer.new.serialize_roadtrip(roadtrip_params[:origin], roadtrip_params[:destination])
      if roadtrip_info.is_a?(Hash) && roadtrip_info[:error].present?
        render json: { errors: 'Impossible' }, status: :unprocessable_entity
      else
        render json: roadtrip_info
      end
    # elsif a field is left blank (move above)
    else
      render json: { errors: 'Invalid api key, please try again' }, status: :unprocessable_entity
    end
  end

  private
  
  def roadtrip_params
    payload = JSON.parse(request.body.read, symbolize_names: true)
    ActionController::Parameters.new(payload).permit(:origin, :destination, :api_key)
  end
end
