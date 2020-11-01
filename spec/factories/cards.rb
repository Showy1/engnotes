FactoryBot.define do
  factory :card do
    english_text { 'ENGLISH_TEXT' }
    japanese_text { '日本語の文章' }
    source { 'https://example.com' }
    user_id { 1 }
  end
end

# == Schema Information
#
# Table name: cards
#
#  id            :bigint           not null, primary key
#  english_text  :text(65535)      not null
#  japanese_text :text(65535)      not null
#  lock_version  :integer
#  phase         :integer          default(0)
#  source        :text(65535)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint
#
