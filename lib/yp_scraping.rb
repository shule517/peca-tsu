# YPから配信履歴を取得する
class YPScraping
  attr_reader :history_url
  def initialize(history_url)
    @history_url = history_url
  end

  def enable?
    days.count != 0
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

  def details(date_list)
    date_list.map { |date| detail(date) }
  end

  def detail(date)
    date = date.to_s.gsub('-', '')
    name = broadcast_doc(date).css('.main h2').text.gsub(' - Statistics', '')
    details = broadcast_doc(date).css('.log tr').map do |day_doc|
      elem = day_doc.css('td').map { |td| td.text }
      { time: elem[0], age: elem[1], listener: elem[2], description: elem[3] }
    end.drop(1) # ヘッダーを削除
    return {} if details.first.nil?
    desc = details.first[:description]
    return {} if desc.nil?
    desc.gsub!(/^\[/, '')
    desc.gsub!(/」$/, '')
    desc_str = desc.split(']').first
    data = [nil, nil, nil]
    data = desc_str.split(' - ') unless desc_str.nil?
    comment = desc.split('「').last

    broadcast_date = Date.parse(date)
    start_time = DateTime.parse("#{broadcast_date} #{details.first[:time]}")
    end_time = DateTime.parse("#{broadcast_date} #{details.last[:time]}")
    time = end_time.to_time - start_time.to_time
    {
      name: name,
      date: broadcast_date,
      time: time / 60.0 / 60.0,
      start_time: start_time,
      end_time: end_time,
      genre: data[0],
      detail: data[1],
      contact_url: data[2],
      comment: comment,
    }
    # TODO 配信中に詳細を変更したときのことを考慮したい
    # TODO 配信を再起動したときは新しい配信としてみたくない 同じ詳細なら
    # TODO 配信が日をまたいだ場合に 同じ詳細が続くのもやだ
  end

  private

  def calendar_doc
    @calendar_doc ||= history_doc.css('.side .calendar')
  end

  def history_doc
    # http://temp.orz.hm/yp/getgmt.php?cn=しっかりシュールｃｈ
    @history_doc ||= Shule::Http.get_document(history_url)
  end

  def broadcast_doc(date)
    # http://temp.orz.hm/yp/getgmt.php?cn=しっかりシュールｃｈ&date=20161211
    url = "#{history_url}&date=#{date}"
    Shule::Http.get_document(url)
  end
end
