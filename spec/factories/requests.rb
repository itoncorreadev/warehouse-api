FactoryGirl.define do
  factory :request do
    date { Faker::Date.forward }
    request_type 'in'
    description { Faker::Lorem.sentence }
    document_type 'nf'
    document_code { Faker::Number.number(digits: 10) }
    observation { Faker::Lorem.sentence }
    status false
    supplier
    department
    user
  end
end
