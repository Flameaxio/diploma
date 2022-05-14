# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root to: 'workspaces#index'

  resources :workspaces, only: %i[index show create] do
    post :move_card, on: :member
    post :change_assignee, on: :member
    resources :cards, only: %i[show create] do
      post :post_message
    end
    resources :columns, only: %i[update create destroy]
    resources :users, only: %i[index]
  end
end
