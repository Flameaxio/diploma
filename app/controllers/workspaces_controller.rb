# frozen_string_literal: true

class WorkspacesController < ApplicationController
  def index
    render json: Workspace.all
  end

  def show
    workspace = Workspace.find_by(id: params[:id])
    render json: WorkspaceSerializer.new(workspace).serializable_hash
  end
end
