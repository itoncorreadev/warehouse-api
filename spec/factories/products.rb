FactoryGirl.define do
  factory :product do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    code { Faker::Number.number(digits: 10) }
    product_type false
    measure 'un'
    min { Faker::Number.number(digits: 2) }
    med { Faker::Number.number(digits: 2) }
    max { Faker::Number.number(digits: 2) }
    location { Faker::Lorem.sentence }
    group
    category
  end
end
