# frozen_string_literal: true

class ColumnSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :id, :name

  attribute :webhook do |object|
    object.webhook ? { url: object.webhook.url, body: object.webhook.body } : {}
  end
end
