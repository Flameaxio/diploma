# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'homepage#show'

  resources :workspaces do
    post :move_card, on: :member
    resources :cards, only: %i[show]
  end
end
