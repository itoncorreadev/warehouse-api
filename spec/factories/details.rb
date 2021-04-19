FactoryBot.define do
  factory :detail do
    quantity { Faker::Number.number(digits: 2) }
    unit_price { Faker::Number.number(digits: 2) }
    total_price { Faker::Number.number(digits: 2) }
    observation { Faker::Lorem.sentence }
    product
    request
  end
end
