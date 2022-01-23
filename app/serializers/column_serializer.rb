# frozen_string_literal: true

class ColumnSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name
end
