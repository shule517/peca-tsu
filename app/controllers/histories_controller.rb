class HistoriesController < ApplicationController
  def index
    @histories = History.where(genre: user_params[:genre]).order(:start_time).reverse
    render json: @histories
  end

  private

  # リクエストパラメータのバリデーション
  def user_params
    params.permit(:name, :genre)
  end
end
