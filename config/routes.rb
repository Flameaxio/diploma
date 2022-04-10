# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'homepage#show'

  resources :workspaces do
    post :move_card, on: :member
    resources :cards, only: %i[show] do
      post :post_message
    end
  end
end
