require './spec/rails_helper'

describe YPScraping do
  describe '配信した日の一覧が取得できること' do
    let(:history_url) { 'http://temp.orz.hm/yp/getgmt.php?cn=%E3%81%97%E3%81%A3%E3%81%8B%E3%82%8A%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%AB%EF%BD%83%EF%BD%88' }
    let(:history) { YPScraping.new(history_url) }
    it { expect(history.days).to include Date.parse('2012/03/24') } # 最古の配信日
    it { expect(history.days).to include Date.parse('2016/12/11') } # 最新の配信日
  end
end
