class YP < Thor
  TP_URL = 'http://temp.orz.hm/yp/'
  SP_URL = 'http://bayonet.ddo.jp/sp/'

  desc 'get_channel', 'チャンネルを取得する'
  def get_channel
    puts 'チャンネル取得！'
    # puts channels.map { |ch| ch[:name] }
    channels.each do |ch|
      create_channel(ch).save
    end
  end

  private

  def channels
    [TP_URL, SP_URL].flat_map do |url|
      YPParser.parse_from_web(url)
    end
  end

  def create_channel(channel)
    Channel.new do |ch|
      ch.name = channel[:name]
      ch.last_genre = channel[:genre]
    end
  end
end
