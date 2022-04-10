# frozen_string_literal: true

class CardLog < ApplicationRecord
  belongs_to :card

  enum action_type: { move: 0, change_status: 1 }

  DEFAULT_MESSAGES = ->(from:, to:) {
    {
      move: "The ticket has been moved from '#{from}' to '#{to}'",
      change_status: "The status was changed from '#{from}' to '#{to}'"
    }
  }
end
