# frozen_string_literal: true

class CardSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :id, :title, :scoped_id, :body, :created_at

  attribute :status do |object|
    object.column.name
  end

  attribute :card_logs do |object|
    CardLogSerializer.new(object.card_logs).serializable_hash[:data].map { |c| c[:attributes] }
  end
end
