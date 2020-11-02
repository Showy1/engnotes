require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  let(:user) { create(:user, confirmed_at: DateTime.now) }
  # ref. spec/factories/cards.rb
  # sequence(:username) { |n| 'TEST_NAME#{n}' }
  # sequence(:email) { |n| 'TEST#{n}@example.com' }
  # password {'password'}

  scenario 'login with username' do
    visit '/users/sign_in'

    expect(page).to have_content 'Log in'

    fill_in 'Login', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content user.username
  end

  scenario 'login with email' do
    visit '/users/sign_in'

    expect(page).to have_content 'Log in'

    fill_in 'Login', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content user.username
  end
end
