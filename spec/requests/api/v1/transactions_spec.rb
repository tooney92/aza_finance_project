# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Transactions', type: :request do
  let!(:subject) { User.create({ user_name: 'demo_transaction_user', password: '12345678' }) }

  let(:token) { user_login(subject) }

  describe 'GET /index' do
    before do
      FactoryBot.create_list(:transaction, 10)
      get '/api/v1/transactions?page=1', headers: { 'Authorization' => token }, xhr: true
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all transactions' do
      json = JSON.parse(response.body)
      expect(json['transactions'].size).to eq(10)
    end

    it 'has transactions as a field' do
      json = JSON.parse(response.body)
      expect(json.keys).to contain_exactly('transactions')
    end
  end

  describe 'GET /show' do
    context 'valid id' do
      let!(:transaction) { FactoryBot.create(:transaction) }

      before do
        get "/api/v1/transactions/#{transaction.id}", headers: { 'Authorization' => token }, xhr: true
      end

      it 'returns status code 200 for valid transaction ID' do
        expect(response).to have_http_status(:success)
      end

      it 'should have appropriate response body' do
        json = JSON.parse(response.body)
        expect(json['transaction'].keys).to contain_exactly(
          'transaction_id',
          'customer_id',
          'input_amount',
          'input_currency',
          'output_amount',
          'output_currency',
          'transaction_date',
          'uuid'
        )
      end
    end

    context 'invalid id' do
      before do
        get '/api/v1/transactions/wrong_id', headers: { 'Authorization' => token }, xhr: true
      end

      it 'returns status code 404 for valid transaction ID' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      let!(:new_transaction) { FactoryBot.build(:transaction) }
      # new_transaction = FactoryBot.build(:transaction)
      before do
        post '/api/v1/transactions', params:
          {
            transaction: {
              'customer_id': new_transaction.customer_id,
              'input_amount': new_transaction.input_amount,
              'input_currency': new_transaction.input_currency,
              'output_amount': new_transaction.output_amount,
              'output_currency': new_transaction.output_currency
            }
          }, headers: { 'Authorization' => token }, xhr: true
      end

      it 'returns the valid response fields' do
        json = JSON.parse(response.body)
        expect(json['transaction'].keys).to contain_exactly(
          'transaction_id',
          'customer_id',
          'input_amount',
          'input_currency',
          'output_amount',
          'output_currency',
          'transaction_date',
          'uuid'
        )
      end
    end

    context 'with invalid parameters' do
      before do
        post '/api/v1/transactions', params:
          { transaction: {
            'customer_id': '',
            'input_amount': ''
          } }, headers: { 'Authorization' => token }
      end

      it 'returns a unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
