# frozen_string_literal: true

FactoryBot.define do
  factory :column do
    name { "column_#{Faker::Name.first_name}_#{rand 100000}" }
  end
end
