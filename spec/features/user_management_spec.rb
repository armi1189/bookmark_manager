require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature 'User signs up' do
  scenario 'when being a new user visiting the site' do
    expect { sign_up }.to change(User, :count).by 1
    expect(page).to have_content('Welcome, bob@example.com')
    expect(User.first.email).to eq('bob@example.com')
  end
  scenario 'with a password that does not match' do
    expect { sign_up('a@a.com', 'pass', 'wrong') }.to change(User, :count).by 0
    expect(current_path).to eq('/users')
    expect(page).to have_content('Password does not match')
  end
  scenario 'with an email that is already registered' do
    expect { sign_up }.to change(User, :count).by 1
    expect { sign_up }.to change(User, :count).by 0
    expect(page).to have_content('This email is already taken')
  end
end

feature 'User signs in' do

  before(:each) do
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
  end

  scenario 'with correct credentials' do
    visit '/'
    expect(page).not_to have_content('Welcome, test@test.com')
    sign_in('test@test.com', 'test')
    expect(page).to have_content('Welcome, test@test.com')
  end

  scenario 'with incorrect credentials' do
    visit '/'
    expect(page).not_to have_content('Welcome, test@test.com')
    sign_in('test@test.com', 'wrong')
    expect(page).not_to have_content('Welcome, test@test.com')
  end

end

feature 'User signs out' do

  before(:each) do
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
  end

  scenario 'while being signed in' do
    sign_in('test@test.com', 'test')
    click_button 'Sign out'
    expect(page).to have_content('Good Bye!')
    expect(page).not_to have_content('Welcome, test@test.com')
  end

end

feature 'Users lost his password' do
  before(:each) do
    User.create(email: 'test@test.com',
                password: 'test',
                password_confirmation: 'test')
  end

  # scenario 'he wants to reset it' do
  #   reset_form('test@test.com')
  #   token = User.first.password_token
  #   visit "/reset_password/#{token}"
  #   old_password = User.first.password_digest
  #   change_form('new_password', 'new_password')
  #   expect(User.first.password_digest).not_to eq old_password
  #   expect(User.first.password_token).to be_nil
  # end

  # scenario 'he wants to reset it but he puts wrong password confirmation' do
  #   reset_form('test@test.com')
  #   token = User.first.password_token
  #   visit "/reset_password/#{token}"
  #   change_form('new_password', 'new_wrong_password')
  #   expect(page).to have_content('Password does not match the confirmation')
  # end

  scenario 'he cannot reset if the token is older than one hour' do
    user = User.first
    user.password_token = "abcd"
    user.password_token_timestamp = Time.new(2015, 4, 9, 12, 0, 0)
    user.save
    visit "/reset_password/#{user.password_token}"
    expect(page).to have_content('Token time has expired!')
  end
end