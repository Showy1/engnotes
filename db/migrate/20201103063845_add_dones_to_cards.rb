class AddDonesToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :done, :boolean, default: false, null: false
    add_column :cards, :done_time, :date
    add_column :cards, :note, :text
  end
end
