# frozen_string_literal: true

class CardLog < ApplicationRecord
  belongs_to :card
  belongs_to :performed_by, class_name: 'User'

  enum action_type: { move: 0, change_status: 1, message: 2 }

  DEFAULT_MESSAGES = ->(from:, to:) {
    {
      move: "The ticket has been moved from <strong>'#{from}'</strong> to <strong>'#{to}'</strong>",
      change_status: "The status was changed from <strong>'#{from}'</strong> to <strong>'#{to}'</strong>"
    }
  }
end
