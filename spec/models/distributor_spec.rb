require 'rails_helper'

RSpec.describe Distributor, type: :model do
  describe "basic tests" do
    before :each do
      @distributor = FactoryGirl.create(:distributor)
    end

    it "should be able to create a distributor" do
      expect(@distributor.name).to eq("AK Press")
      expect(@distributor.notes).to eq("wow what nice books you have")
      expect(@distributor.our_account_number).to eq("1234567890")
      expect(@distributor.to_s).to eq("AK Press (#{@distributor.id})")
    end
  end
end
