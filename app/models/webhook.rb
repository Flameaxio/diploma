# frozen_string_literal: true

class Webhook < ApplicationRecord
  belongs_to :column

  def interpolated_text(assignee:, card:)
    Mustache.render(body, assignee: assignee&.full_name, assignee_email: assignee&.email,
                          ticket_number: card&.scoped_id, ticket_title: card&.title, column_name: column&.name)
  end

  def active?
    url.present? && body.present?
  end
end
