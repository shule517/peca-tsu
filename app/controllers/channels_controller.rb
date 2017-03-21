require 'uri'

class ChannelsController < ApplicationController
  def index
    name = user_params[:name]
    @channels = Channel.where(name: name)
    if @channels.count == 0
      sp_url = 'http://bayonet.ddo.jp/sp/'
      tp_url = 'http://temp.orz.hm/yp/'
      [sp_url, tp_url].each do |yp_url|
        history_url = "#{yp_url}getgmt.php?cn=#{name}"
        history = YPScraping.new(URI.escape(history_url))
        next unless history.enable?
        update_history(history)
        update_channel(history, yp_url)
      end
      @channels = Channel.where(name: name)
    end
    render json: @channels
  end

  private

  def update_history(history)
    broadcast_days = history.days.reverse.take(30)
    details = history.details(broadcast_days)
    details.each do |detail|
      puts detail
      create_history(detail)
    end
  end

  def create_history(history)
    ch = History.find_or_create_by(name: history[:name], date: history[:date])
    ch.name = history[:name]
    ch.date = history[:date]
    ch.start_time = history[:start_time]
    ch.end_time = history[:end_time]
    ch.genre = history[:genre]
    ch.detail = history[:detail]
    ch.contact_url = history[:contact_url]
    ch.comment = history[:comment]
    p ch
    ch.save
  end

  def update_channel(history, yp_url)
    broadcast_lastday = history.days.reverse.first
    detail = history.detail(broadcast_lastday)
    puts detail
    create_channel(detail, yp_url)
  end

  def create_channel(history, yp_url)
    ch = Channel.find_or_create_by(name: history[:name])
    ch.name = history[:name]
    ch.yp_url = yp_url
    ch.contact_url = history[:contact_url] if history[:contact_url].present?
    ch.last_genre = history[:genre]
    ch.last_detail = history[:detail]
    ch.last_comment = history[:comment]
    ch.last_started_at = history[:start_time]
    ch.save
  end

  # リクエストパラメータのバリデーション
  def user_params
    params.permit(:name)
  end
end
