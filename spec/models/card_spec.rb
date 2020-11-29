require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:user) { create(:user, confirmed_at: DateTime.now) }
  let(:card) { build(:card, user_id: user.id) }
  # ref. spec/factories/cards.rb
  # english_text { 'ENGLISH_TEXT' }
  # japanese_text { '日本語の文章' }
  # source { 'https://example.com' }

  it 'is valid with english_text, japanese_text, source and user_id' do
    expect(card).to be_valid
  end

  it 'is invalid without english_test' do
    card.english_text = ''
    card.valid?
    expect(card.errors[:english_text]).to include("can't be blank")
  end
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
