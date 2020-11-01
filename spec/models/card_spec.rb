require 'rails_helper'

RSpec.describe Card, type: :model do
  before do
    @card = build(:card)
    # ref. spec/factories/cards.rb
    # english_text {"ENGLISH_TEXT"}
    # japanese_text {"日本語の文章"}
    # source {"https://example.com"}
    # user_id {1}
  end

  it 'is valid with english_text, japanese_text, source and user_id' do
    expect(@card).to be_valid
  end

  it 'is invalid without english_test' do
    pending
    @card.english_text = ''
    # expect(@card).to be_valid
    @card.valid?
    expect(@card.errors[:english_text]).to include("can't be blank")
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
