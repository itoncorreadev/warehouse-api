FactoryBot.define do
  factory :group do
    name { Faker::Food.fruits}
    status { "true"  }
  end
end
