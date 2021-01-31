FactoryGirl.define do
  factory :request do
    date { Faker::Date.forward }
    type 'in'
    document 'nf'
    document_code { Faker::Number.number(digits: 10) }
    quantity { Faker::Number.decimal_part(digits: 2) }
    unit_price { Faker::Commerce.price(range: 0..10.0, as_string: true) }
    total_price { Faker::Number.decimal_part(digits: 2) }
    observation { Faker::Lorem.sentence }
    status false
    product
    department
  end
end
