FactoryGirl.define do
  factory :sale_order do
    sequence(:total_in_cents) { |n| 100 + n }
    discount_percent 0
    notes "wow, a sale!"
  end

end
