class AddUserIdToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :user_id, :bigint
  end
end
