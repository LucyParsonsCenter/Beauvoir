require 'rails_helper'

RSpec.describe Copy, type: :model do

  describe "copy state" do
    before :each do
      @copy = FactoryGirl.create(:copy)
    end

    it "should be 'in_stock' by default" do
      expect(@copy.state).to eq("in_stock")
    end

    it "should be able to be marked sold" do
      @copy.sell
      expect(@copy.state).to eq("sold")
    end

    it "should be able to be moved to the library" do
      @copy.move_to_library
      expect(@copy.state).to eq("checked_in")
    end

    it "should be able to be checked in and out of the library" do
      @copy.move_to_library
      expect(@copy.state).to eq("checked_in")
      @copy.check_out
      expect(@copy.state).to eq("checked_out")
      @copy.check_in
      expect(@copy.state).to eq("checked_in")
    end

    it "should be able to be marked 'lost'" do
      @copy.mark_lost_inventory
      expect(@copy.state).to eq("lost")
    end

    it "should be able to be marked 'found'" do
      @copy.mark_lost_inventory
      expect(@copy.state).to eq("lost")
      @copy.mark_found_inventory
      expect(@copy.state).to eq("in_stock")
    end

    it "should be able to be marked 'found' for the library" do
      @copy.move_to_library
      @copy.mark_lost_library
      expect(@copy.state).to eq("lost")
      @copy.mark_found_library
      expect(@copy.state).to eq("checked_in")
    end
  end
end
