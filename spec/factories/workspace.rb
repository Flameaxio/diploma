# frozen_string_literal: true

FactoryBot.define do
  factory :workspace do
    name { "workspace_#{Faker::Name.first_name}_#{rand 100000}" }
  end
end
