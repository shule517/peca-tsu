# YP(index.txt)からチャンネル情報を取得する
class YP < Thor
  TP_URL = 'http://temp.orz.hm/yp/'
  SP_URL = 'http://bayonet.ddo.jp/sp/'

  desc 'get_channel', 'チャンネルを取得する'
  def get_channel
    channels.each do |ch|
      create_channel(ch)
    end
  end

  private

  def channels
    [TP_URL, SP_URL].flat_map do |url|
      YPParser.parse_from_web(url)
    end
  end

  def create_channel(channel)
    ch = Channel.find_or_create_by(name: channel[:name])
    ch.name = channel[:name]
    ch.yp_url = channel[:yp_url]
    ch.contact_url = channel[:url] if channel[:url].present?
    ch.last_genre = channel[:genre]
    ch.last_detail = channel[:desc]
    ch.last_comment = channel[:comment]
    ch.last_started_at = channel[:started_at]
    ch.save
  end
end
