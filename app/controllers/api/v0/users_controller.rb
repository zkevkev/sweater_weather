class Api::V0::UsersController < ApplicationController
  def create
    json_data = JSON.parse(request.body, symbolize_names: true)
    user = User.new(user_params(json_data))
    user.api_key = SecureRandom.hex(16)

    if user.save
      render json: UserSerializer.new(user).serialized_json
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params(data)
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
