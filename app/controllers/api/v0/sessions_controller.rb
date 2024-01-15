class Api::V0::SessionsController < ApplicationController
  def create
    data = JSON.parse(request.body.read)
    
  end
end
