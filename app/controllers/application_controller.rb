# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonWebToken
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordNotUnique, with: :duplicate_record

  private

  def record_not_found(error)
    render json: { errors: error.message }, status: 404
  end

  def duplicate_record(_error)
    render json: { errors: 'user name already exists' }, status: 400
  end

  def authenticate_request
    header = request.headers['Authorization']
    render json: { error: 'no token sent' }, status: :bad_request and return if header.nil?

    header = header.split(' ').last if header

    @current_user = jwt_decode(header)
  end
end
