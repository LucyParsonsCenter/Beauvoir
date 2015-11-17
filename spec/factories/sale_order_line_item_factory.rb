FactoryGirl.define do
  factory :sale_order_line_item do
    sequence(:sale_price_in_cents) { |n| 100 + n }
  end

end
