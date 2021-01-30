FactoryGirl.define do
  factory :product do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    category { Faker::Lorem.sentence }
    code { Faker::Number.number(digits: 10) }
    type false
    measure { Faker::Lorem.sentence }
    min { Faker::Number.decimal_part(digits: 2) }
    med { Faker::Number.decimal_part(digits: 2) }
    max { Faker::Number.decimal_part(digits: 2) }
    location { Faker::Lorem.sentence }
    status true
    group
  end
end
