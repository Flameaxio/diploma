# frozen_string_literal: true

class AddNameToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.string :first_name, null: false
      t.string :middle_name, default: ''
      t.string :last_name, null: false
    end
  end
end
