class Api::V1::AuthenticationController < ApplicationController


  def login
    @user = User.find_by_user_name(params[:user_name])
    if @user&.authenticate(params[:password])
      token = jwt_encode({ user_id: @user.id })
      time = Time.now + 1.day.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     user_name: @user.user_name }, status: :ok

    else
      render json: { error: 'wrong user_name or password' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:user_name, :password)
  end
end
