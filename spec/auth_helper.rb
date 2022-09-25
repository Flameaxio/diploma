# frozen_string_literal: true

require 'spec_helper'

module AuthHelper
  include Warden::Test::Helpers

  def login_user
    user = FactoryBot.create(:user)
    scope = Devise::Mapping.find_scope!(user)
    login_as(user, scope: scope)
  end
end
