FactoryBot.define do
  factory :category do
    description { Faker::Lorem.sentence }
    status {"true"}
  end
end
