# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :card_logs, dependent: :nullify, foreign_key: :performed_by_id, inverse_of: :performed_by
  has_many :cards, dependent: :nullify, foreign_key: :assignee_id, inverse_of: :assignee

  def full_name
    "#{first_name} #{middle_name&.truncate(2, omission: '.')} #{last_name}"
  end
end
