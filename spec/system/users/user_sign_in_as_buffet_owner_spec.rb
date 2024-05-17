require 'rails_helper'

describe 'User sign in as buffets owner' do
  before do
    @buffet_owner = User.create!(
      email: 'buffet_owner@example.com',
      password: 'password',
      name: 'Buffet Owner',
      buffet_owner: true
    )

    visit root_path
    click_on 'Login'
  end

  it 'displays the sign in page' do
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_button('Log in')
  end

  it 'signs in successfully with valid credentials' do
    fill_in 'Email', with: @buffet_owner.email
    fill_in 'Password', with: @buffet_owner.password
    click_on 'Log in'

    expect(page).to have_content("Hello, Buffet Owner #{@buffet_owner.name}")
  end

  it 'fails to sign in with invalid credentials' do
    fill_in 'Email', with: @buffet_owner.email
    fill_in 'Password', with: 'wrong_password'
    click_on 'Log in'

    expect(page).to have_content('Invalid Email or password.')
  end
end
