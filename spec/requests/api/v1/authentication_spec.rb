# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Authentications', type: :request do

  let!(:subject) {User.create({ user_name: 'demo2', password: '12345678' })}

  describe 'POST /api/v1/auth/login' do
    context 'valid login' do
      before(:each) do
        post '/api/v1/auth/login', params: {
          user_name: subject.user_name,
          password: '12345678'
        }
      end

      it 'should return return token' do
        json = JSON.parse(response.body)
        expect(json).to include("token", "exp", "user_name")
      end
    end
  end

  describe 'POST /api/v1/auth/login' do
    context 'valid login' do
      before(:each) do
        post '/api/v1/auth/login', params: {
          user_name: 'wrong_user',
          password: '12345678'
        }
      end

      it 'should not return token' do
        expect(response.status).to eq(401)
      end
    end
  end
end
