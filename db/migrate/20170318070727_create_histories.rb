class CreateHistories < ActiveRecord::Migration[5.0]
  def change
    create_table :histories do |t|
      t.text :name
      t.date :date
      t.datetime :start_time
      t.datetime :end_time
      t.text :genre
      t.text :desc
      t.text :comment
      t.text :contact_url

      t.timestamps
    end
  end
end
