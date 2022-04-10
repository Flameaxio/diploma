# frozen_string_literal: true

class Card < ApplicationRecord
  belongs_to :workspace
  belongs_to :column
  has_many :card_logs

  before_create :assign_scoped_id

  private

  def assign_scoped_id
    last_scoped_id = Card.where(workspace_id: workspace.id).
      order(id: :desc).
      limit(1).
      select(:scoped_id).
      first&.scoped_id
    last_scoped_id ||= 0
    self.scoped_id = last_scoped_id + 1
  end
end
