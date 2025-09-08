# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    name { Faker::Food.fruits }
    status { 'true' }
  end
end
