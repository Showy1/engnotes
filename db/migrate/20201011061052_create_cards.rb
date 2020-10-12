class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.text :japanese_text, null: false
      t.text :english_text, null: false
      t.text :source
      t.integer :phase, limit: 1, default: 0

      t.timestamps
      t.integer :lock_version
    end
  end
end
