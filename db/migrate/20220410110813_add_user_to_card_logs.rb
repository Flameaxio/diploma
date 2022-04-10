# frozen_string_literal: true

class AddUserToCardLogs < ActiveRecord::Migration[5.2]
  def change
    add_column :card_logs, :performed_by_id, :integer, null: false
    add_index :card_logs, :performed_by_id
  end
end
