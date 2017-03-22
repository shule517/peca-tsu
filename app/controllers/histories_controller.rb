class HistoriesController < ApplicationController
  def index
    name = user_params[:name]
    keyword = user_params[:keyword]
    if name.present?
      @histories = History.where(name: name).order(:end_time).reverse
      render json: @histories
    else
      @histories = History.where("name like '\%#{keyword}\%' or genre like '\%#{keyword}\%' or detail like '\%#{keyword}\%' or comment like '\%#{keyword}\%'").order(:end_time).reverse
      render json: @histories
    end
  end

  private

  # リクエストパラメータのバリデーション
  def user_params
    params.permit(:keyword, :name)
  end
end
