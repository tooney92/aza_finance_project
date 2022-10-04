json.transactions @transactions do |transaction|
  json.transaction_id transaction.id
  json.customer_id transaction.customer_id
  json.input_currency transaction.input_currency
  json.input_amount transaction.input_amount
  json.output_amount transaction.output_amount
  json.output_currency transaction.output_currency
  json.transaction_date transaction.created_at
  json.uuid transaction.uuid
end
