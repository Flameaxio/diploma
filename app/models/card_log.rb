# frozen_string_literal: true

class CardLog < ApplicationRecord
  belongs_to :card
  belongs_to :performed_by, class_name: 'User'

  enum action_type: { move: 0, change_assignee: 1, message: 2 }

  before_create :trigger_webhook

  DEFAULT_MESSAGES = ->(from:, to:) {
    {
      move: "The ticket has been moved from <strong>'#{from}'</strong> to <strong>'#{to}'</strong>",
      change_assignee: "The assignee was changed from <strong>'#{from}'</strong> to <strong>'#{to}'</strong>"
    }
  }

  private

  def trigger_webhook
    return if action_type != 'move' || !card.column.webhook&.active?

    url = card.column.webhook.url
    body = JSON.parse(card.column.webhook.interpolated_text(assignee: card.assignee,
                                                            card: card)).transform_values(&:presence).compact.to_json
    HTTParty.post(url, body: body, headers: { 'Content-Type' => 'application/json' })
  end
end
