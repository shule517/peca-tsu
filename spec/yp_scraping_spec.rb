require './spec/rails_helper'

describe YPScraping do
  describe '配信した日の一覧が取得できること' do
    let(:history) { YPScraping.new(history_url) }
    context 'TPの場合' do
      let(:history_url) { 'http://temp.orz.hm/yp/getgmt.php?cn=%E3%81%97%E3%81%A3%E3%81%8B%E3%82%8A%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%AB%EF%BD%83%EF%BD%88' }
      it { expect(history.days).to include Date.parse('2012/03/24') } # 最古の配信日
      it { expect(history.days).to include Date.parse('2016/12/11') } # 最新の配信日
    end
    context 'SPの場合' do
      let(:history_url) { 'http://bayonet.ddo.jp/sp/getgmt.php?cn=%E4%B8%AD%E5%B1%B1' }
      it { expect(history.days).to include Date.parse('2012/12/24') } # 最古の配信日
      it { expect(history.days).to include Date.parse('2017/03/18') } # 最新の配信日
    end
  end
  describe '配信の詳細が取得できること' do
    let(:history) { YPScraping.new(history_url) }
    context 'TPの場合' do
      let(:history_url) { 'http://temp.orz.hm/yp/getgmt.php?cn=%E3%81%97%E3%81%A3%E3%81%8B%E3%82%8A%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%AB%EF%BD%83%EF%BD%88' }
      let(:detail) { history.detail('2016/12/09') }
      it { expect(detail[:start_time]).to eq '19:10' } # 配信開始時間
      it { expect(detail[:end_time]).to eq '23:50' } # 配信終了時間
      it { expect(detail[:genre]).to eq 'プログラミング' }
      it { expect(detail[:detail]).to eq 'rails初心者が21:00までに Pecaハッカソン用ページをなんとしてでも作る！' }
      it { expect(detail[:contact_url]).to eq 'http://jbbs.shitaraba.net/bbs/read.cgi/game/45037/1481031910/' }
      it { expect(detail[:comment]).to eq '21:00から開会式配信はっじまるよー　今日から3日間はPeerCast忘年会ハッカソン！' }
    end
    context 'SPの場合' do
      let(:history_url) { 'http://bayonet.ddo.jp/sp/getgmt.php?cn=%E4%B8%AD%E5%B1%B1' }
      # it { expect(history.days).to include Date.parse('2012/12/24') } # 最古の配信日
      # it { expect(history.days).to include Date.parse('2017/03/18') } # 最新の配信日
    end
  end
end