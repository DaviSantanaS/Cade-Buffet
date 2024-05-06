require 'rails_helper'

describe 'unauthenticated visitor access' do

  it 'and theres no buffets' do
    visit root_path

    expect(page).to have_content('No buffets available.')
  end


  it 'can see the list of buffets' do
    @buffet_owner = User.create!(
      email: 'buffet_owner@example.com',
      password: 'password',
      name: 'Buffet Owner',
      buffet_owner: true
    )

    @buffet = Buffet.create!(
      name: 'Buffet Name',
      company_name: 'Buffet Company Name',
      cnpj: '22202911000134',
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

    @buffet_owner_2 = User.create!(
      email: 'buffet_owner2@example.com',
      password: 'password',
      name: 'Buffet Owner 2',
      buffet_owner: true
    )

    @buffet_2 = Buffet.create!(
      name: 'Buffet Name 2',
      company_name: 'Buffet Company Name 2',
      cnpj: '22202911000134',
      phone: '23-45678-9012',
      contact_email: 'buffet2@email.com',
      address: 'Buffet Address 2',
      district: 'Buffet District 2',
      state: 'CA',
      city: 'Buffet City 2',
      description: 'Buffet Description 2',
      payment_methods: 'Buffet Payment methods 2',
      zip_code: '23456789',
      user_id: @buffet_owner_2.id
    )

    @buffet_owner_3 = User.create!(
      email: 'buffet_owner3@example.com',
      password: 'password',
      name: 'Buffet Owner 3',
      buffet_owner: true
    )

    @buffet_3 = Buffet.create!(
      name: 'Buffet Name 3',
      company_name: 'Buffet Company Name 3',
      cnpj: '22202911000134',
      phone: '34-56789-0123',
      contact_email: 'buffet3@email.com',
      address: 'Buffet Address 3',
      district: 'Buffet District 3',
      state: 'NY',
      city: 'Buffet City 3',
      description: 'Buffet Description 3',
      payment_methods: 'Buffet Payment methods 3',
      zip_code: '34567890',
      user_id: @buffet_owner_3.id
    )

    @buffet_owner_4 = User.create!(
      email: 'buffet_owner4@example.com',
      password: 'password',
      name: 'Buffet Owner 4',
      buffet_owner: true
    )

    @buffet_4 = Buffet.create!(
      name: 'Buffet Name 4',
      company_name: 'Buffet Company Name 4',
      cnpj: '22202911000134',
      phone: '45-67890-1234',
      contact_email: 'buffet4@email.com',
      address: 'Buffet Address 4',
      district: 'Buffet District 4',
      state: 'FL',
      city: 'Buffet City 4',
      description: 'Buffet Description 4',
      payment_methods: 'Buffet Payment methods 4',
      zip_code: '45678901',
      user_id: @buffet_owner_4.id
    )

    visit root_path

    expect(page).to have_content('Buffet Name')
    expect(page).to have_content('BS')
    expect(page).to have_content('Buffet City')

    expect(page).to have_content('Buffet Name 2')
    expect(page).to have_content('CA')
    expect(page).to have_content('Buffet City 2')

    expect(page).to have_content('Buffet Name 3')
    expect(page).to have_content('NY')
    expect(page).to have_content('Buffet City 3')

    expect(page).to have_content('Buffet Name 4')
    expect(page).to have_content('FL')
    expect(page).to have_content('Buffet City 4')
  end


end
