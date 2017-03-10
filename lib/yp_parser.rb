class YPParser
  def self.parse_from_web(yp_url)
    open(yp_url).read
  end

  def self.parse(body)
    self.new.parse(body)
  end

  def parse(body)
  end

  private

end
