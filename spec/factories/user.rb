# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { "#{Faker::Name.first_name}_#{rand 100000}" }
    middle_name { Faker::Name.middle_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirmed_at { Time.now }
  end
end
