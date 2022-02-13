# frozen_string_literal: true

class CardBriefSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :id, :title, :scoped_id
end
