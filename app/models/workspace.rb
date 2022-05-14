# frozen_string_literal: true

class Workspace < ApplicationRecord
  has_many :cards, dependent: :destroy
  has_many :columns, dependent: :destroy

  after_create :create_default_columns

  private

  def create_default_columns
    columns.create(name: 'Open')
    columns.create(name: 'In progress')
    columns.create(name: 'Review')
    columns.create(name: 'Closed')
  end
end
