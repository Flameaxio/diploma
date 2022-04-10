# frozen_string_literal: true

class WorkspacesController < ApplicationController
  before_action :load_workspace, only: %i[show move_card]
  before_action :load_card, only: [:move_card]

  def index
    respond_to do |r|
      r.html
      r.json do
        render json: Workspace.all
      end
    end
  end

  def show
    respond_to do |r|
      r.html
      r.json do
        render json: WorkspaceSerializer.new(@workspace).serializable_hash
      end
    end
  end

  def move_card
    from = @card.column.name
    if @card.update(column_id: params[:to_id])
      @card.card_logs.create(action_type: :move,
                             message: CardLog::DEFAULT_MESSAGES.call(from: from,
                                                                     to: @card.column.name)[:move],
                             performed_by: current_user)
      render json: WorkspaceSerializer.new(@workspace).serializable_hash
    else
      render head(:unprocessable_entity)
    end
  end

  private

  def load_workspace
    @workspace = Workspace.find(params[:id])
  end

  def load_card
    @card = @workspace.cards.find(params[:card_id])
  end
end
