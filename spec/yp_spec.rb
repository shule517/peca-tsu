require './spec/rails_helper'
describe YPParser do
  let(:tp_url) { 'http://temp.orz.hm/yp/' }
  let(:sp_url) { 'http://bayonet.ddo.jp/sp/' }
  describe '各YPから情報が取得できること' do
    it 'TPから取得できること' do
      expect(YPParser.parse_from_web(tp_url).count).to be > 0
    end
    it 'SPから取得できること' do
      expect(YPParser.parse_from_web(sp_url).count).to be > 0
    end
  end

  describe 'index.txtをパースできること' do
    let(:index_text) {
      <<~TEXT
        test channel1<>0123456789012345678901234567890<>127.0.0.1:7144<>http://example.com<>Some genre<>any desc - &lt;Open&gt;<>10<>20<>7144<>FLV<>track creator<>track album<>track title<>track url<>test%20channel1<>0:00<>click<>comment area<>0
        test channel2<>0123456789012345678901234567890<>127.0.0.1:7144<>http://example.com<>Some genre<>any desc - &lt;Open&gt;<>10<>20<>7144<>FLV<>track creator<>track album<>track title<>track url<>test%20channel2<>0:01<>click<>comment area<>0
        test channel3<>0123456789012345678901234567890<>127.0.0.1:7144<>http://example.com<>Some genre<>any desc - &lt;Open&gt;<>10<>20<>7144<>FLV<>track creator<>track album<>track title<>track url<>test%20channel3<>0:02<>click<>comment area<>0
      TEXT
    }
    let (:channels) { YPParser.parse(index_text) }
    it { expect(channels.count).to eq 3 }

    let (:channel) { channels.first }
    it { expect(channel[:name]).to eq 'test channel1' }
  end
end
