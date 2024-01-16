class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])

    if user
      render json: UserSerializer.new(user)
    else
      render json: { errors: 'Invalid credentials, please try again' }, status: :unprocessable_entity
    end
  end

  private

  def session_params
    payload = JSON.parse(request.body.read, symbolize_names: true)
    ActionController::Parameters.new(payload).permit(:email, :password)
  end
end
