class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    user.api_key = SecureRandom.hex(16)

    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    payload = JSON.parse(request.body.read, symbolize_names: true)
    ActionController::Parameters.new(payload).permit(:email, :password, :password_confirmation)
  end
end
