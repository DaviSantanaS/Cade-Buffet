require 'rails_helper'

describe 'user signup' do

  it 'displays the sign up page to regular user' do

    visit root_path
    click_on 'Login'
    click_on 'Sign up'
    select 'Regular User', from: 'user_role'



    expect(page).to have_content('Sign up')
    expect(page).to have_content('Email')
    expect(page).to have_content('Password')
    expect(page).to have_content('Password confirmation')
    expect(page).to have_content('Name')
    expect(page).to have_content('CPF')
  end

end