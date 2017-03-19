class History < ApplicationRecord
  def time
    # 配信時間(秒)
    end_time.to_time - start_time.to_time
  end
end
