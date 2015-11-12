require 'rails_helper'

RSpec.describe Publisher, type: :model do
  describe "basic tests" do
    before :each do
      @publisher = FactoryGirl.create(:publisher)
    end

    it "should let you create a publisher" do
      expect(@publisher.name).to eq("Rendom Hoose")
      expect(@publisher.description).to eq("well, you know")
    end
  end
end
