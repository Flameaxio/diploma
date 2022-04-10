# frozen_string_literal: true

class CardLogSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :id, :message

  attribute :created_at do |object|
    object.created_at.to_i
  end
end
