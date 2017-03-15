class YPParser
  def self.parse_from_web(yp_url)
    index_text = open("#{yp_url}index.txt").read
    channels = parse(index_text)
    p channels.map { |channel| channel[:name] }
    channels
  end

  def self.parse(body)
    self.new.parse(body)
  end

  def parse(body)
    channels = body.split(/\n/).map { |line| parse_line(line) }
    channels.reject { |channel| channel[:listeners].to_i < -1 }
  end

  private

  def parse_line(line)
    elements = line.split(/<>/)
    keys = [:name, :id, :ip, :url, :genre, :desc, :listeners, :relays, :bitrate, :type, :track_creator, :track_album, :track_title, :track_url, :a, :time, :click, :comment, :direct]
    channel = keys.zip(elements).to_h
    channel[:started_at] = Time.now - time_to_second(channel[:time])
    channel
  end

  def time_to_second(time)
    h = time[/^[0-9]+/].to_i
    m = time[/[0-9]+$/].to_i
    (h * 60 * 60) + (m * 60)
  end
end
