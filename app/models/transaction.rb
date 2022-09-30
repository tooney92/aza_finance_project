class Transaction < ApplicationRecord
  validates_presence_of :customer_id
  validates_presence_of :input_amount
  validates_numericality_of :input_amount
  validates_presence_of :input_currency
  validates_numericality_of :output_amount
  validates_presence_of :output_currency
end
