require './spec/rails_helper'
describe YPParser do
  let(:tp_url) { 'http://temp.orz.hm/yp/' }
  let(:sp_url) { 'http://bayonet.ddo.jp/sp/' }

  # it 'YPからチャンネル情報が取得できること' do
  #   # let(:channels) { YPParser.parse_from_web('http://bayonet.ddo.jp/sp/') }
  #   # let(:channel) { channel.find{ |ch| ch.name == '中山' } }
  #   # expect(channels.count).to eq 16
  #   expecs(YPParser.parse_from_web(sp_url)).to eq 16
  # end
  # describe '各YPから情報が取得できること' do
  #   it 'TP'
  #   it 'SP'
  # end

  it '' do
    index_txt = <<-TEXT
test channel1<>0123456789012345678901234567890<>127.0.0.1:7144<>http://example.com<>Some genre<>any desc - &lt;Open&gt;<>10<>20<>7144<>FLV<>track creator<>track album<>track title<>track url<>test%20channel1<>0:00<>click<>comment area<>0"
test channel2<>0123456789012345678901234567890<>127.0.0.1:7144<>http://example.com<>Some genre<>any desc - &lt;Open&gt;<>10<>20<>7144<>FLV<>track creator<>track album<>track title<>track url<>test%20channel2<>0:01<>click<>comment area<>0"
test channel3<>0123456789012345678901234567890<>127.0.0.1:7144<>http://example.com<>Some genre<>any desc - &lt;Open&gt;<>10<>20<>7144<>FLV<>track creator<>track album<>track title<>track url<>test%20channel3<>0:02<>click<>comment area<>0"
TEXT
    expect{ YPParser.parse(index_txt) }.not_to raise_error
  end
end
