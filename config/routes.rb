# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'homepage#show'

  resources :workspaces do
    post :move_card, on: :member
    post :change_assignee, on: :member
    resources :cards, only: %i[show] do
      post :post_message
    end
    resources :columns, only: %i[update]
    resources :users, only: %i[index]
  end
end
