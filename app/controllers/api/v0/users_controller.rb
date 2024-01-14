class Api::V0::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save!
      render json: UserSerializer.new # method
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation) # :api_key
  end
end
