require 'rails_helper'

RSpec.describe User, type: :model do

  context "VInvalidalid user" do

    let(:invalid_user) {User.new({
                                   user_name: ""
                                 })}

    it "is invalid with with no username" do
      expect(invalid_user).not_to be_valid
    end

  end

  context "Valid user" do

    let(:valid_user) {User.new({user_name: "demo", password: "12345678"})}

    it "is invalid with with no username" do
      expect(valid_user).to be_valid
    end

  end
end
