FactoryBot.define do
  factory :transaction do
    customer_id {rand(1..7)}
    input_amount {rand(1000..7000)}
    input_currency {"Naira"}
    output_amount {rand(100...700)}
    output_currency {"Dollar"}
  end
end
