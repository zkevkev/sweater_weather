class Api::V0::SessionsController < ApplicationController
  def create
    data = JSON.parse(request.body.read)
    user = User.find_by(email: user_params(data)[:email])

    if user
      render json: UserSerializer.new(user)
    else
      render json: { errors: 'Invalid credentials, please try again' }, status: :unprocessable_entity
    end
  end

  private

  def user_params(data)
    # params.require(:user).permit(:email, :password, :password_confirmation)

    user_params = {
      email: data['email'],
      password: data['password'],
    }
  end
end
