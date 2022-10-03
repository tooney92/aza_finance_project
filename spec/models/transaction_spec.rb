require 'rails_helper'

RSpec.describe Transaction, type: :model do

  let!(:subject){FactoryBot.build(:transaction)}

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a customer_id" do
    subject.customer_id = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a input_amount" do
    subject.input_amount = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a input_currency" do
    subject.input_currency = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a output_amount" do
    subject.output_amount = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a output_currency" do
    subject.output_currency = nil
    expect(subject).to_not be_valid
  end

end
