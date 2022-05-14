# frozen_string_literal: true

class CardsController < ApplicationController
  before_action :load_card, except: %i[create]
  before_action :load_workspace, only: %i[create]

  def show
    respond_to do |r|
      r.html
      r.json do
        render json: CardSerializer.new(@card).serializable_hash
      end
    end
  end

  def post_message
    card_log = @card.card_logs.create(action_type: :message,
                                      message: params[:message],
                                      performed_by: current_user)
    render json: CardLogSerializer.new(card_log).serializable_hash
  end

  def create
    @workspace.cards.create(card_params)
  end

  private

  def load_card
    @card = Card.find(params[:id] || params[:card_id])
  end

  def card_params
    params.require(:ticket).permit(:title, :body, :assignee_id, :column_id)
  end

  def load_workspace
    @workspace = Workspace.find(params[:workspace_id])
  end
end
