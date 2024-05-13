require 'rails_helper'

describe 'user signup', type: :system do

  it 'displays the sign up page to regular user without JS' do
    visit root_path
    click_on 'Login'
    click_on 'Sign up'

    expect(page).to have_content('Sign up')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Password confirmation')
    expect(page).to have_content('Name')
  end

  it 'toggles CPF field visibility based on user role selection', js: true do
    visit root_path
    click_on 'Login'
    click_on 'Sign up'

    select 'Regular User', from: 'user_role'
    expect(page).to have_selector('.cpf_field', visible: true)

    select 'Buffet Owner', from: 'user_role'
    expect(page).to have_selector('.cpf_field', visible: false)
  end

  it 'successfully registers a regular user', js: true do
    visit root_path
    click_on 'Login'
    click_on 'Sign up'
    select 'Regular User', from: 'user_role'

    fill_in 'Name', with: 'John Doe'
    fill_in 'Email', with: 'email@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    fill_in 'CPF', with: '831.669.330-50'

    click_on 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
end
