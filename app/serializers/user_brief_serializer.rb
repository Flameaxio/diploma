# frozen_string_literal: true

class UserBriefSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :id, :full_name, :email
end
