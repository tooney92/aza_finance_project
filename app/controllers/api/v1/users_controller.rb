class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    render json: user.errors.messages, status: :bad_request unless user.save
  end

  def user_params
    params.permit(
      :user_name,  :password
    )
  end
end
