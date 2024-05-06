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
  context 'already loged in as a regular_user' do
    it 'to root path when try to edit a buffet by url' do
      @buffet_owner = User.create!(
        email: 'buffet_owner@example.com',
        password: 'password',
        name: 'Buffet Owner',
        buffet_owner: true
      )

      @buffet = Buffet.create!(
        name: 'Buffet Name',
        company_name: 'Buffet Company Name',
        cnpj: '28934084000150',
        phone: '12-34567-8901',
        contact_email: 'buffet@email.com',
        address: 'Buffet Address',
        district: 'Buffet District',
        state: 'BS',
        city: 'Buffet City',
        description: 'Buffet Description',
        payment_methods: 'Buffet Payment methods',
        zip_code: '12345678',
        user_id: @buffet_owner.id
      )

      @regular_user = User.create!(
        email: 'regular_user@example.com',
        password: 'password',
        name: 'Regular User',
        cpf: '52998224725',
        buffet_owner: false
      )

      login_as @regular_user, scope: :user
      visit 'http://127.0.0.1:3000/buffets/1/edit'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Only the buffet owner can perform this action')
    end

    it 'to root path when try to create a new price event by url' do
      visit 'http://127.0.0.1:3000/event_types/1/event_prices/new'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You are not authorized to perform this action.')
    end

  end
  context 'already loged in as a buffet_owner' do
    it 'to root path when try to edit a buffet from another buffet owner' do
      @buffet_owner = User.create!(
        email: 'buffet_owner@example.com',
        password: 'password',
        name: 'Buffet Owner',
        buffet_owner: true
      )

      @buffet = Buffet.create!(
        name: 'Buffet Name',
        company_name: 'Buffet Company Name',
        cnpj: '28934084000150',
        phone: '12-34567-8901',
        contact_email: 'buffet@email.com',
        address: 'Buffet Address',
        district: 'Buffet District',
        state: 'BS',
        city: 'Buffet City',
        description: 'Buffet Description',
        payment_methods: 'Buffet Payment methods',
        zip_code: '12345678',
        user_id: @buffet_owner.id
      )

      @buffet_owner2 = User.create!(
        email: 'buffet_owner2@example.com',
        password: 'password',
        name: 'Buffet Owner 2',
        buffet_owner: true
      )

      @buffet2 = Buffet.create!(
        name: 'Buffet Name 2',
        company_name: 'Buffet Company Name 2',
        cnpj: '28934084000150',
        phone: '98-76543-2109',
        contact_email: 'buffet2@email.com',
        address: 'Buffet Address 2',
        district: 'Buffet District 2',
        state: 'AB',
        city: 'Buffet City 2',
        description: 'Buffet Description 2',
        payment_methods: 'Buffet Payment methods 2',
        zip_code: '87654321',
        user_id: @buffet_owner2.id
      )

      login_as @buffet_owner, scope: :user
      visit 'http://127.0.0.1:3000/buffets/2/edit'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('Only the buffet owner can perform this action')

    end

  end
end



