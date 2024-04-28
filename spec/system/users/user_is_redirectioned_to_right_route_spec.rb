require 'rails_helper'

describe 'User is redirectioned ' do
  context 'signup' do
    it 'to new buffet page after signup' do

      visit root_path
      click_on 'Login'
      click_on 'Sign up'
      fill_in 'Name', with: 'Buffet Owner'
      fill_in 'Email', with: 'buffet_owner@example.com'
      fill_in 'Password', with: 'strongpassword'
      fill_in 'Password confirmation', with: 'strongpassword'
      select 'Buffet Owner', from: 'user_role'
      click_on 'Sign up'

      expect(page).to have_content('New Buffet')
      expect(current_path).to eq(new_buffet_path)
    end
  end

  context 'already has a user' do
    it 'to new buffet page after login' do
      @buffet_owner = User.create!(
        email: 'buffet_owner@example.com',
        password: 'strongpassword',
        name: 'Buffet Owner',
        buffet_owner: true)

      login_as @buffet_owner, scope: :user
      visit root_path


      expect(page).to have_content('New Buffet')
      expect(current_path).to eq(new_buffet_path)

    end

  end

  context 'does not have signed in' do
    it 'to log in page' do
      visit buffets_path

      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(current_path).to eq(new_user_session_path)

    end
  end
  context 'already loged in' do

  end
end



