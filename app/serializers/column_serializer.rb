# frozen_string_literal: true

class ColumnSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :id, :name
  
  attribute :cards do |object|
    CardBriefSerializer.new(object.cards).serializable_hash[:data].map { |c| c[:attributes] }
  end
end
