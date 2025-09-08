# frozen_string_literal: true

FactoryBot.define do
  factory :department do
    description { Faker::Lorem.sentence }
    status { 'true' }
  end
end
