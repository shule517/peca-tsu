require './spec/rails_helper'

describe YPScraping do
  describe 'チャンネル履歴があるか判定' do
    let(:history) { YPScraping.new(history_url) }
    context 'TPの場合' do
      context '存在する場合' do
        let(:history_url) { 'http://temp.orz.hm/yp/getgmt.php?cn=%E3%81%97%E3%81%A3%E3%81%8B%E3%82%8A%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%AB%EF%BD%83%EF%BD%88' }
        it { expect(history.enable?).to eq true }
      end
      context '存在しない場合' do
        let(:history_url) { 'http://temp.orz.hm/yp/getgmt.php?cn=xxxxxx' }
        it { expect(history.enable?).to eq false }
      end
    end
    context 'SPの場合' do
      context '存在する場合' do
        let(:history_url) { 'http://bayonet.ddo.jp/sp/getgmt.php?cn=%E4%B8%AD%E5%B1%B1' }
        it { expect(history.enable?).to eq true }
      end
      context '存在しない場合' do
        let(:history_url) { 'http://bayonet.ddo.jp/sp/getgmt.php?cn=xxxxxx' }
        it { expect(history.enable?).to eq false }
      end
    end
  end
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
      context '通常' do
        let(:history_url) { 'http://temp.orz.hm/yp/getgmt.php?cn=%E3%81%97%E3%81%A3%E3%81%8B%E3%82%8A%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%AB%EF%BD%83%EF%BD%88' }
        let(:detail) { history.detail(Date.parse('2016/12/09')) }
        it { expect(detail[:name]).to eq 'しっかりシュールｃｈ' }
        it { expect(detail[:date]).to eq Date.parse('2016/12/09') }
        it { expect(detail[:start_time]).to eq DateTime.parse('2016/12/09 19:10') } # 配信開始時間
        it { expect(detail[:end_time]).to eq DateTime.parse('2016/12/09 23:50') } # 配信終了時間
        it { expect(detail[:genre]).to eq 'プログラミング' }
        it { expect(detail[:detail]).to eq 'rails初心者が21:00までに Pecaハッカソン用ページをなんとしてでも作る！' }
        it { expect(detail[:contact_url]).to eq 'http://jbbs.shitaraba.net/bbs/read.cgi/game/45037/1481031910/' }
        it { expect(detail[:comment]).to eq '21:00から開会式配信はっじまるよー　今日から3日間はPeerCast忘年会ハッカソン！' }
      end
      context '詳細のみ コメントがない場合' do
        let(:history_url) { 'http://temp.orz.hm/yp/getgmt.php?cn=%E3%81%8E%E3%82%82' }
        let(:detail) { history.detail(Date.parse('2017/03/17')) }
        it { expect(detail[:name]).to eq 'ぎも' }
        it { expect(detail[:date]).to eq Date.parse('2017/03/17') }
        it { expect(detail[:start_time]).to eq DateTime.parse('2017/03/17 21:50') } # 配信開始時間
        it { expect(detail[:end_time]).to eq DateTime.parse('2017/03/17 23:50') } # 配信終了時間
        it { expect(detail[:genre]).to eq 'game' }
        it { expect(detail[:detail]).to eq 'ゼルダの伝説BOTW' }
        it { expect(detail[:contact_url]).to eq 'http://jbbs.shitaraba.net/bbs/read.cgi/internet/4074/1481269391/l50' }
        it { expect(detail[:comment]).not_to eq nil }
      end
      context 'ジャンル・コメントあり、詳細・コンタクトURLなし の場合' do
        let(:history_url) { 'http://temp.orz.hm/yp/getgmt.php?cn=ADmaru' }
        let(:detail) { history.detail(Date.parse('2017/03/11')) }
        it { expect(detail[:name]).to eq 'ADmaru' }
        it { expect(detail[:date]).to eq Date.parse('2017/03/11') }
        it { expect(detail[:start_time]).to eq DateTime.parse('2017/03/11 05:50') } # 配信開始時間
        it { expect(detail[:end_time]).to eq DateTime.parse('2017/03/11 23:50') } # 配信終了時間
        it { expect(detail[:genre]).to eq '【PS】' }
        it { expect(detail[:detail]).to eq nil }
        it { expect(detail[:contact_url]).to eq nil }
        it { expect(detail[:comment]).to eq '見られなかったらコメントください' }
      end
      context '全て未設定の場合' do
        let(:history_url) { 'http://temp.orz.hm/yp/getgmt.php?cn=ADmaru' }
        let(:detail) { history.detail(Date.parse('2017/03/19')) }
        it { expect(detail[:name]).to eq 'ADmaru' }
        it { expect(detail[:date]).to eq Date.parse('2017/03/19') }
        it { expect(detail[:start_time]).to eq DateTime.parse('2017/03/19 00:00') } # 配信開始時間
        # it { expect(detail[:end_time]).to eq DateTime.parse('2017/03/19 11:40') } # 配信終了時間 # まだ配信中
        it { expect(detail[:genre]).to eq nil }
        it { expect(detail[:detail]).to eq nil }
        it { expect(detail[:contact_url]).to eq nil }
        it { expect(detail[:comment]).to eq nil }
      end
    end
    context 'SPの場合' do
      let(:history_url) { 'http://bayonet.ddo.jp/sp/getgmt.php?cn=%E4%B8%AD%E5%B1%B1' }
      let(:detail) { history.detail(Date.parse('2017/03/06')) }
      it { expect(detail[:name]).to eq '中山' }
      it { expect(detail[:date]).to eq Date.parse('2017/03/06') }
      it { expect(detail[:start_time]).to eq DateTime.parse('2017/03/06 05:30') } # 配信開始時間
      it { expect(detail[:end_time]).to eq DateTime.parse('2017/03/06 11:20') } # 配信終了時間
      it { expect(detail[:genre]).to eq 'プログラミング' }
      it { expect(detail[:detail]).to eq 'slackで色々通知できるようにする' }
      it { expect(detail[:contact_url]).to eq nil }
      it { expect(detail[:comment]).not_to eq nil }
    end
  end
end
