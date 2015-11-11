require 'rails_helper'

RSpec.describe Author, type: :model do
  describe "basic tests" do
    before :each do
      @author = FactoryGirl.create(:author)
    end

    it "should be able to create an author" do
      expect(@author.first_name).to eq("KJ")
      expect(@author.full_name).to eq("KJ Bowling")
    end

    it "should allow setting a bio" do
      bio = "The author of the famous Larby Botter series"
      @author.update(bio: bio)
      expect(@author.bio).to eq(bio)
    end
  end
end
