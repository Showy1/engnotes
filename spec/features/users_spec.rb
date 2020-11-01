require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  let(:user) { create(:user, confirmed_at: DateTime.now) }

  scenario 'login' do
    visit root_path

    expect(page).to have_content 'Log in'

    fill_in 'Login', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content user.username
  end
end
