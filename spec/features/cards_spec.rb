require 'rails_helper'

RSpec.feature 'Cards', type: :feature do
  let(:user) { create(:user, confirmed_at: DateTime.now) }
  # ref. spec/factories/cards.rb
  # sequence(:username) { |n| 'TEST_NAME#{n}' }
  # sequence(:email) { |n| 'TEST#{n}@example.com' }
  # password {'password'}

  background do
    # login
    visit '/users/sign_in'
    fill_in 'Login', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  scenario 'a new card is created and deleted', js: true do
    expect(page).to have_content user.username

    find('#input_japanese_text').set('テキスト')
    find('#input_english_text').set('text')
    find('#input_source').set('https://text.com')
    click_on 'Submit'

    expect(page).to have_content 'テキスト'
    expect(page).not_to have_content 'text'

    click_on 'テキスト'

    expect(page).to have_content 'text'

    click_on 'delete'

    expect(page).not_to have_content 'テキスト'
  end
end
