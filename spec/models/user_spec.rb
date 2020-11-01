require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
    # ref. spec/factories/users.rb
    # sequence(:username) { |n| "TEST_NAME#{n}" }
    # sequence(:email) { |n| "TEST#{n}@example.com" }
    # password {"password"}
  end

  it 'is valid with username, email and password' do
    expect(@user).to be_valid
  end

  it 'is invalid without username' do
    @user.username = ''
    @user.valid?
    expect(@user.errors[:username]).to include('is too short (minimum is 3 characters)')
  end

  it 'is invalid with short username' do
    @user.username = 'Xu'
    @user.valid?
    expect(@user.errors[:username]).to include('is too short (minimum is 3 characters)')
  end

  it 'is invalid without email' do
    @user.email = ''
    @user.valid?
    expect(@user.errors[:email]).to include("can't be blank")
  end

  it 'is invalid with duplicated email' do
    pending
    user1 = create(:user)
    user2 = FactoryBot.build(:user)
    user2.valid?
    expect(user2.errors[:email]).to include('is too short (minimum is 3 characters)')
  end

  it 'is invalid without password' do
    @user.password = ''
    @user.valid?
    expect(@user.errors[:password]).to include("can't be blank")
  end

  it 'has encrypted password' do
    expect(@user.encrypted_password).not_to eq('password')
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  unconfirmed_email      :string(255)
#  username               :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
