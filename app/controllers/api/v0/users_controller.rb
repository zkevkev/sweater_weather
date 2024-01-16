class Api::V0::UsersController < ApplicationController
  def create
    data = request.body.read
    require 'pry'; binding.pry
    user = User.new(user_params(data))
    user.api_key = SecureRandom.hex(16)

    if user.save
      render json: UserSerializer.new(user)
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params(data)
    # params.permit(:email, :password, :password_confirmation)

    user_params = {
      email: data['email'],
      password: data['password'],
      password_confirmation: data['password_confirmation']
    }
  end
end
