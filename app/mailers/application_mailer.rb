# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  include SendGrid
  default from: 'noreply@flameaxe.me'
  layout 'mailer'
end
