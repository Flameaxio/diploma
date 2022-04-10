# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :card_logs, dependent: :nullify

  def full_name
    "#{first_name} #{middle_name&.truncate(1, omission: '.')} #{last_name}"
  end
end
