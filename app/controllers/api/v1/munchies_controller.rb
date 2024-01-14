class Api::V1::MunchiesController < ApplicationController
  def show
    location = params[:location].split(',')
    cuisine = params[:food]
    render json: MunchiesSerializer.new.serialize_munchies(location[0], location[1], cuisine)
  end
end
