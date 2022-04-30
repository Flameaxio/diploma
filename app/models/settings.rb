# frozen_string_literal: true

class Settings < Settingslogic
  # The source of the configuration file
  source "#{Rails.root}/config/settings.yml"
  namespace Rails.env
  load!
end
