class AddColumnToChannels < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :yp_url, :text
    add_column :channels, :last_comment, :text
  end
end
