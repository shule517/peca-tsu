class HistoriesController < ApplicationController
  def index
    keyword = user_params[:keyword]
    @histories = History.where("name like '\%#{keyword}\%' or genre like '\%#{keyword}\%' or detail like '\%#{keyword}\%' or comment like '\%#{keyword}\%'").order(:end_time).reverse
    render json: @histories
  end

  private

  # リクエストパラメータのバリデーション
  def user_params
    params.permit(:keyword)
  end
end
