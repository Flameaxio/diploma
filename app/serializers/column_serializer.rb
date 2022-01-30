# frozen_string_literal: true

class ColumnSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :id, :name, :cards
end
