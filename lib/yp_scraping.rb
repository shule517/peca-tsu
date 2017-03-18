# YPから配信履歴を取得する
class YPScraping
  attr_reader :history_url
  def initialize(history_url)
    @history_url = history_url
  end

  def days
    list = []
    history_doc.css('.side .calendar').each do |month_doc|
      month = month_doc.css('.idx').text
      month_doc.css('.a').each do |day_doc|
        day = day_doc.text
        date = "#{month}/#{day}"
        list << Date.parse(date)
      end
    end
    list
  end

  private

  def history_doc
    @history_doc ||= Shule::Http.get_document(history_url)
  end
end
