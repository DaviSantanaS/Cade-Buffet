require 'rails_helper'

describe 'User sign up as buffets owner' do
  before do
    visit root_path
    click_on 'Login'
    click_on 'Sign up'
  end

  it 'displays the sign up page' do
    expect(page).to have_content('Sign up')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Password confirmation')
    expect(page).to have_content('Name')
    expect(page).not_to have_content('CPF')
  end

  it 'signs up successfully as buffets owner' do
    fill_in 'Name', with: 'Test'
    fill_in 'Email', with: 'test@gmail.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    select 'Buffet Owner', from: 'user_role'
    click_on 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Hello, Buffet Owner Test')
  end


end
