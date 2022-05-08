# frozen_string_literal: true

class Column < ApplicationRecord
  has_many :cards, dependent: :destroy
  has_one :webhook, dependent: :destroy, required: false

  belongs_to :workspace
end
