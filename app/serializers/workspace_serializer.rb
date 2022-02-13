# frozen_string_literal: true

class WorkspaceSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :name

  attribute :columns do |object|
    ColumnSerializer.new(object.columns).serializable_hash[:data].map { |c| c[:attributes] }
  end
end
