# Channelsの配信履歴をYPから取得する
class HistoryTask < Thor
  desc 'get_history', '配信履歴を取得する'
  def get_history
    puts '開始！'
    channels = Channel.where.not(yp_url: nil)
    channels.take(1).each do |ch|
      history = YPScraping.new(ch.history_url)
      broadcast_days = history.days.reverse.take(30)
      details = history.details(broadcast_days)

      details.each do |detail|
        puts detail
        create_history(detail)
      end
    end
  end

  private

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
end
