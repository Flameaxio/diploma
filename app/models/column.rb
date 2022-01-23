# frozen_string_literal: true

class Column < ApplicationRecord
  has_many :cards, dependent: :destroy

  belongs_to :workspace
end
