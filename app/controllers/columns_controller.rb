# frozen_string_literal: true

class ColumnsController < ApplicationController
  before_action :load_column, only: %i[update destroy]
  before_action :load_workspace, only: %i[create]

  def update
    if @column.update(column_params)
      if webhook_params.compact.present?
        webhook = Webhook.find_or_initialize_by(column: @column)
        webhook.assign_attributes(webhook_params)
        webhook.save
      end
      render json: ColumnSerializer.new(@column.reload).serializable_hash
    end
  end

  def create
    column = @workspace.columns.create(column_params)
    unless column.errors.any?
      if webhook_params.compact.present?
        webhook = Webhook.find_or_initialize_by(column: column)
        webhook.assign_attributes(webhook_params)
        webhook.save
      end
      return render json: ColumnSerializer.new(column.reload).serializable_hash
    end
    render json: column.errors.full_messages, status: :unprocessable_entity
  end

  def destroy
    @column.destroy
    render json: 'ok', status: :ok
  end

  private

  def load_column
    @column = Column.find(params[:id])
  end

  def load_workspace
    @workspace = Workspace.find(params[:workspace_id])
  end

  def column_params
    {
      name: params[:name]
    }
  end

  def webhook_params
    {
      url: params[:url],
      body: params[:body]
    }
  end
end
