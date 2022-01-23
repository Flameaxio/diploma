# frozen_string_literal: true

class Workspace < ApplicationRecord
  has_many :cards, dependent: :destroy
  has_many :columns, dependent: :destroy
end
