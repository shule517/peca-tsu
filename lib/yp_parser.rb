class YPParser
  def self.parse_from_web(yp_url)
    index_text = open("#{yp_url}index.txt").read
    channels = parse(index_text)
    p channels.map{|ch|ch[:name]}
    channels
  end

  def self.parse(body)
    self.new.parse(body)
  end

  def parse(body)
    body.split(/\n/).map { |line| parse_line(line) }
  end

  private

  def parse_line(line)
    elements = line.split(/<>/)
    keys = [:name, :id, :ip, :url, :genre, :desc, :listeners, :relays, :bitrate, :type, :track_creator, :track_album, :track_title, :track_url, :a, :time, :click, :comment, :direct]
    keys.zip(elements).to_h
  end
end
