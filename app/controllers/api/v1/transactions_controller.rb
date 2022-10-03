class Api::V1::TransactionsController < ApplicationController

  before_action :set_transaction, only: %i[show]
  before_action :authenticate_request

  def index
    @transactions = Transaction.page(params.fetch(:page))
  end

  def show; end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:customer_id, :input_currency, :input_amount, :output_amount, :output_currency)
  end
end
