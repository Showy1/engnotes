class AddYoutubeIdAndChangeNullToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :youtube_id, :string

    change_column_null :cards, :japanese_text, true
  end
end
