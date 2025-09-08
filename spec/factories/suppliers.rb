# frozen_string_literal: true

FactoryBot.define do
  factory :supplier do
    description { Faker::Lorem.sentence }
    type_document { 'CPF' }
    document { '111.222.333-44' }
    address { Faker::Address.full_address }
    phone { Faker::PhoneNumber.phone_number }
    comment { Faker::Lorem.sentence }
  end
end
