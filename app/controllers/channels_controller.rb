class ChannelsController < ApplicationController
  def index
    @channels = Channel.where(name: user_params[:name])
    render json: @channels
  end

  private

  # リクエストパラメータのバリデーション
  def user_params
    params.permit(:name)
  end
end
