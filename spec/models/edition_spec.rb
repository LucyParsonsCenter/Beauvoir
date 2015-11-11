require 'rails_helper'

RSpec.describe Edition, type: :model do
  describe "basic tests" do
    before :each do
      @edition = FactoryGirl.create(:edition)
    end

    it "should let you create an edition" do
      expect(@edition.notes).to eq("wow, a book!")
      expect(@edition.list_price_cents).to eq(230)
    end

    it "should throw an error if the ISBN is invalid" do
      expect { FactoryGirl.create(:edition, isbn10: "1234567890") }.to raise_error
    end
  end
end
