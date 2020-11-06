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

  scenario 'a new card is created, done and deleted', js: true do
    # confirm login
    expect(page).to have_content user.username

    # create a new card and confirm shown
    find('#input_japanese_text').set('テキスト')
    find('#input_english_text').set('text')
    find('#input_source').set('https://text.com')
    click_on 'Submit'
    expect(page).to have_content 'テキスト'
    expect(page).not_to have_content 'text'

    # click card and confirm opened
    click_on 'テキスト'
    expect(page).to have_content 'text'
    expect(page).to have_content 'done'

    # done and confirm unshown
    click_on 'done'
    expect(page).not_to have_content 'テキスト'

    # show done list and confirm shown
    click_on 'Done'
    expect(page).to have_content 'テキスト'
    expect(page).not_to have_content 'text'

    # click card and confirm opened
    click_on 'テキスト'
    expect(page).to have_content 'text'
    expect(page).to have_content 'delete'

    # delete card and confirm it
    click_on 'delete'
    expect(page).not_to have_content 'テキスト'
  end

  scenario 'a new card is created and done / the card is shown a day later / the card is shown 4 days later', js: true do
    # confirm login
    expect(page).to have_content user.username

    # create a new card and confirm shown
    find('#input_japanese_text').set('テキスト')
    find('#input_english_text').set('text')
    find('#input_source').set('https://text.com')
    click_on 'Submit'
    expect(page).to have_content 'テキスト'
    expect(page).not_to have_content 'text'

    # click card and confirm opened
    click_on 'テキスト'
    expect(page).to have_content 'text'
    expect(page).to have_content 'done'

    # done and confirm unshown
    click_on 'done'
    expect(page).not_to have_content 'テキスト'
    visit current_path
    expect(page).not_to have_content 'テキスト'

    # a day later
    travel 1.day
    visit current_path
    expect(page).to have_content 'テキスト'
    click_on 'テキスト'
    expect(page).to have_content 'text'
    expect(page).to have_content 'done'
    click_on 'done'
    expect(page).not_to have_content 'テキスト'

    # 3 days later
    travel 3.days
    visit current_path
    expect(page).not_to have_content 'テキスト'

    # a day later
    travel 1.day
    visit current_path
    expect(page).to have_content 'テキスト'

    travel_back
  end

  scenario 'a new card is created and done / the card is shown [1, 4, 7, 11, 15, 20, 30] and 30 days later', js: true do
    # confirm login
    expect(page).to have_content user.username

    # create a new card and confirm shown
    find('#input_japanese_text').set('テキスト')
    find('#input_english_text').set('text')
    find('#input_source').set('https://text.com')
    click_on 'Submit'
    expect(page).to have_content 'テキスト'
    expect(page).not_to have_content 'text'

    # click card and confirm opened
    click_on 'テキスト'
    expect(page).to have_content 'text'
    expect(page).to have_content 'done'

    # done and confirm unshown
    click_on 'done'
    expect(page).not_to have_content 'テキスト'

    # shown and done [1, 4, 7, 11, 15, 20, 30] days later
    $review_timings.each do |timing|
      travel timing.day
      visit current_path
      expect(page).to have_content 'テキスト'
      click_on 'テキスト'
      expect(page).to have_content 'text'
      expect(page).to have_content 'done'
      click_on 'done'
      expect(page).not_to have_content 'テキスト'
    end

    # shown and done 30 days later
    travel $review_timings.last.day
    visit current_path
    expect(page).to have_content 'テキスト'
    click_on 'テキスト'
    expect(page).to have_content 'text'
    expect(page).to have_content 'done'
    click_on 'done'
    expect(page).not_to have_content 'テキスト'

    travel_back
  end

  scenario 'two new cards are created and one is searched', js: true do
    # confirm login
    expect(page).to have_content user.username

    # create two new cards and confirm shown
    find('#input_japanese_text').set('1つ目のテキスト')
    find('#input_english_text').set('first text')
    click_on 'Submit'
    find('#input_japanese_text').set('2つ目のテキスト')
    find('#input_english_text').set('second text')
    click_on 'Submit'
    expect(page).to have_content '1つ目のテキスト'
    expect(page).to have_content '2つ目のテキスト'
    expect(page).not_to have_content 'text'

    # search
    find('#input_search').set('1つ目')
    expect(page).to have_content '1つ目のテキスト'
    expect(page).not_to have_content '2つ目のテキスト'

    # reset
    find('#search_reset').click
    expect(page).to have_content '1つ目のテキスト'
    expect(page).to have_content '2つ目のテキスト'
  end
end
