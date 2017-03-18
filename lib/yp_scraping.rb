# YPから配信履歴を取得する
class YPScraping
  attr_reader :history_url
  def initialize(history_url)
    @history_url = history_url
  end

  def days
    calendar_doc.flat_map do |month_doc|
      month = month_doc.css('.idx').text
      month_doc.css('.a').map do |day_doc|
        day = day_doc.text
        date = "#{month}/#{day}"
        Date.parse(date)
      end
    end
  end

  private

  def calendar_doc
    history_doc.css('.side .calendar')
  end

  def history_doc
    @history_doc ||= Shule::Http.get_document(history_url)
  end
end
