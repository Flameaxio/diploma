# frozen_string_literal: true

class CardBriefSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :id, :title, :scoped_id

  attribute :assignee do |object|
    object&.assignee&.email
  end
end
