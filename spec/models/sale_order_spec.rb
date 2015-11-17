require 'rails_helper'

RSpec.describe SaleOrder, type: :model do
  it "should have a valid factory" do
    sale_order = FactoryGirl.create(:sale_order)
  end

  describe "basic tests" do
    before :each do
      @sale_order = FactoryGirl.create(:sale_order)
    end

    it "shouldn't cost anything initially" do
      expect(@sale_order.cost).to eq(0)
    end

    it "should let you get the subtotal" do
      expect(@sale_order.subtotal).to eq(0)
    end

    it "should let you get the total" do
      expect(@sale_order.total).to eq(0)
    end
  end

  describe "adding sale_order_line_items" do
    before :each do
      @sale_order = FactoryGirl.create(:sale_order)
      1.upto 10 do
        @sale_order.sale_order_line_items << FactoryGirl.create(:sale_order_line_item)
      end
    end

    it "should give you the correct total for all the line items" do
      expect(@sale_order.total).to eq(Money.new(1055))
    end

    it "should calculate discount percentage correctly" do
      @sale_order.update(discount_percent: 10)
      expect(@sale_order.total).to eq(Money.new(950))
    end

    it "should calculate tax correctly" do
    end
  end
end
