require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "basic tests" do
    before :each do
      @category = FactoryGirl.create(:category)
    end

    it "should let you create a category" do
      expect(@category.name).to eq("horror")
      expect(@category.description).to eq("so spooky")
    end
  end
end
