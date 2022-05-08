# frozen_string_literal: true

class ColumnSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :id, :name

  attribute :cards do |object|
    CardBriefSerializer.new(object.cards).serializable_hash[:data].map { |c| c[:attributes] }
  end
  
  attribute :webhook do |object|
    object.webhook ? { url: object.webhook.url, body: object.webhook.body } : { }
  end
end
