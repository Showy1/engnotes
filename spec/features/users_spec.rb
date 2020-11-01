require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:user) { create(:user, confirmed_at: DateTime.now) }

  scenario "login" do
    visit root_path

    expect(page).to have_content 'Log in'

    fill_in "Login", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    expect(page).to have_content user.username
    #
    # click_button "Log in"

    # # タスク作成時に、@userのタスクが1つ増えることを記載
    # expect {
    #   # タスク作成ページへ遷移
    #   click_link "New Task"
    #
    #   # タスク名、タスクの説明を入力し、作成ボタンをクリック
    #   fill_in "Name", with: "Test Task"
    #   fill_in "Description", with: "This is Test"
    #   click_button "Create Task"
    #
    #   # タスク作成成功のフラッシュメッセージが表示されること
    #   expect(page).to have_content "Task was successfully created"
    # }.to change(@user.tasks, :count).by(1)
  end
end
