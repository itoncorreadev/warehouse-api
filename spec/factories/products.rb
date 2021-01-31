FactoryGirl.define do
  factory :product do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    category { Faker::Commerce.material }
    code { Faker::Commerce.promotion_code }
    type false
    measure 'un'
    min { Faker::Number.decimal_part(digits: 2) }
    med { Faker::Number.decimal_part(digits: 2) }
    max { Faker::Number.decimal_part(digits: 2) }
    location { Faker::Commerce.department(max: 1, fixed_amount: true) }
    status true
    group
  end
end
