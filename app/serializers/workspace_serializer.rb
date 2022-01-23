# frozen_string_literal: true

class WorkspaceSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :name, :columns, :cards
end
