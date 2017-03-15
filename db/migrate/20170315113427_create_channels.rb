class CreateChannels < ActiveRecord::Migration[5.0]
  def change
    create_table :channels do |t|
      t.string :name
      t.string :contact_url
      t.string :last_genre
      t.string :last_detail
      t.timestamp :last_started_at

      t.timestamps
    end
  end
end
