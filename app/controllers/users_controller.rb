# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    respond_to do |r|
      r.json do
        render json: UserBriefSerializer.new(User.all).serializable_hash
      end
    end
  end
end
