require 'rails_helper'

RSpec.describe Channel, type: :model do
  describe '配信履歴ページが取得できること' do
    context 'TPの場合' do
      let(:yp_url) { 'http://temp.orz.hm/yp/' }
      let(:channel) { Channel.new(name: 'しっかりシュールｃｈ', yp_url: yp_url) }
      it { expect(channel.history_url).to eq 'http://temp.orz.hm/yp/getgmt.php?cn=%E3%81%97%E3%81%A3%E3%81%8B%E3%82%8A%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%AB%EF%BD%83%EF%BD%88' }
    end
    context 'SPの場合' do
      let(:yp_url) { 'http://bayonet.ddo.jp/sp/' }
      let(:channel) { Channel.new(name: '中山', yp_url: yp_url) }
      it { expect(channel.history_url).to eq 'http://bayonet.ddo.jp/sp/getgmt.php?cn=%E4%B8%AD%E5%B1%B1' }
    end
  end
end
