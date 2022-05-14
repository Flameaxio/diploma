# frozen_string_literal: true

class WorkspacesController < ApplicationController
  before_action :load_workspace, except: %i[index create]
  before_action :load_card, only: %i[move_card change_assignee]

  def index
    respond_to do |r|
      r.html
      r.json do
        render json: Workspace.all
      end
    end
  end

  def create
    render json: Workspace.create(name: params[:name])
  end

  def show
    respond_to do |r|
      r.html do
        @current_workspace_json = WorkspaceSerializer.new(@workspace).serializable_hash[:data][:attributes].to_json
        @available_users_json = UserBriefSerializer.new(User.all).serializable_hash[:data].map do |u|
          u[:attributes]
        end.to_json
      end
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

  def change_assignee
    from = @card.assignee&.full_name || 'None'
    to = User.find_by(id: params[:assignee_id])
    if @card.update(assignee: to)
      @card.card_logs.create(action_type: :change_assignee,
                             message: CardLog::DEFAULT_MESSAGES.call(from: from,
                                                                     to: to.full_name)[:change_assignee],
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
