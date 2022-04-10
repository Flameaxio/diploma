# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ws = Workspace.create(name: 'Test Workspace')
open = ws.columns.create(name: 'Open')
ws.columns.create(name: 'In progress')
ws.columns.create(name: 'Review')
ws.columns.create(name: 'Closed')
open.cards.create(title: 'Test', body: 'Test', workspace: ws)
