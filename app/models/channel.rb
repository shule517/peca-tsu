class Channel < ApplicationRecord
  def history_url
    # TPの場合 http://temp.orz.hm/yp/getgmt.php?cn=%E3%81%97%E3%81%A3%E3%81%8B%E3%82%8A%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%AB%EF%BD%83%EF%BD%88
    # SPの場合 http://bayonet.ddo.jp/sp/getgmt.php?cn=%E4%B8%AD%E5%B1%B1
    url = "#{yp_url}getgmt.php?cn=#{name}"
    URI.escape(url)
  end
end
