# frozen_string_literal: true

class ColumnsController < ApplicationController
  before_action :load_column

  def update
    if @column.update(column_params)
      if webhook_params.compact.present?
        webhook = Webhook.find_or_create_by(column: @column)
        webhook.update(webhook_params)
      end
      render json: ColumnSerializer.new(@column.reload).serializable_hash
    end
  end

  private

  def load_column
    @column = Column.find(params[:id])
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
