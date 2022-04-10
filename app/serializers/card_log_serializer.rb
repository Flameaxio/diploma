# frozen_string_literal: true

class CardLogSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :id, :message

  attribute :created_at do |object|
    object.created_at.to_i * 1000
  end

  attribute :performed_by do |object|
    object.performed_by.full_name
  end
end
