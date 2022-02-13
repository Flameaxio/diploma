# frozen_string_literal: true

class CardSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :id, :title, :scoped_id, :body, :created_at

  attribute :status do |object|
    object.column.name
  end
end
