# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :load_card, only: [:show]

  def show
    respond_to do |r|
      r.html
      r.json do
        render json: CardSerializer.new(@card).serializable_hash
      end
    end
  end

  private

  def load_card
    @card = Card.find(params[:id])
  end
end
