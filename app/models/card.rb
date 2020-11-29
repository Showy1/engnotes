class Card < ApplicationRecord
  with_options presence: true do
    validates :english_text
    validates :japanese_text
  end

  belongs_to :user
end

# == Schema Information
#
# Table name: cards
#
#  id            :bigint           not null, primary key
#  done          :boolean          default(FALSE), not null
#  done_time     :date
#  english_text  :text(65535)      not null
#  japanese_text :text(65535)      not null
#  lock_version  :integer
#  note          :text(65535)
#  phase         :integer          default(0)
#  source        :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
