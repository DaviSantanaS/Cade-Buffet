require 'rails_helper'

describe 'visitor searchs for buffets' do
  before do

    @buffet_owner_4 = User.create!(
      email: 'buffet_owner4@example.com',
      password: 'password',
      name: 'Buffet Owner 4',
      buffet_owner: true
    )
    @buffet_owner = User.create!(
      email: 'buffet_owner@example.com',
      password: 'password',
      name: 'Buffet Owner 1',
      buffet_owner: true
    )
    @buffet_owner_3 = User.create!(
      email: 'buffet_owner3@example.com',
      password: 'password',
      name: 'Buffet Owner 3',
      buffet_owner: true
    )
    @buffet_owner_2 = User.create!(
      email: 'buffet_owner2@example.com',
      password: 'password',
      name: 'Buffet Owner 2',
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
    @buffet = Buffet.create!(
      name: 'Buffet Name 1',
      company_name: 'Buffet Company Name',
      cnpj: '22202911000134',
      phone: '12-34567-8901',
      contact_email: 'buffet@email.com',
      address: 'Buffet Address',
      district: 'Buffet District',
      state: 'BS',
      city: 'City',
      description: 'Buffet Description',
      payment_methods: 'Buffet Payment methods',
      zip_code: '12345678',
      user_id: @buffet_owner.id
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
      city: 'City 3',
      description: 'Buffet Description 3',
      payment_methods: 'Buffet Payment methods 3',
      zip_code: '34567890',
      user_id: @buffet_owner_3.id
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

    @event_type_4 = EventType.create!(
      name: 'Event Type Name 4',
      description: 'Event Type Description 4',
      min_capacity: 20,
      max_capacity: 150,
      duration_minutes: 120,
      menu_text: 'Event Type Menu 4',
      has_alcoholic_beverages: true,
      has_decorations: true,
      has_parking_service: true,
      venue_options: "Buffet's Venue 4",
      buffet: @buffet_4,
      days_of_week: 'Monday,Wednesday'
    )
    @event_type_3 = EventType.create!(
      name: 'Event Type Name 3',
      description: 'Event Type Description 3',
      min_capacity: 30,
      max_capacity: 200,
      duration_minutes: 90,
      menu_text: 'Event Type Menu 3',
      has_alcoholic_beverages: true,
      has_decorations: true,
      has_parking_service: false,
      venue_options: "Buffet's Venue 3",
      days_of_week: 'Monday,Wednesday',
      buffet: @buffet_3

    )
    @event_type_2 = EventType.create!(
      name: 'Event Type Name 2',
      description: 'Event Type Description 2',
      min_capacity: 15,
      max_capacity: 120,
      duration_minutes: 75,
      menu_text: 'Event Type Menu 2',
      has_alcoholic_beverages: false,
      has_decorations: true,
      has_parking_service: true,
      venue_options: "Client's Address 2",
      days_of_week: 'Monday,Wednesday',
      buffet: @buffet_2

    )

  end

  it 'and sees all buffets that contais "buff" in name and have some event registered' do
    visit root_path
    fill_in 'query', with: 'Buff'
    click_on 'Search'

    expect(page).not_to have_content('Buffet Name 1')
    expect(page).to have_content('Buffet Name 2')
    expect(page).to have_content('Buffet Name 3')
    expect(page).to have_content('Buffet Name 4')

  end

  it 'and sees all buffets that contains "Buffet City" in city' do
    visit root_path
    fill_in 'query', with: 'Buffet City'
    click_on 'Search'

    expect(page).to have_content('Buffet Name 2')
    expect(page).to have_content('Buffet Name 4')
  end

  it 'and the buffets are ordered by name' do
    visit root_path
    fill_in 'query', with: 'Buff'
    click_on 'Search'

    first_buffet = find('.buffet-list li:first-child').text
    last_buffet = find('.buffet-list li:last-child').text

    expect(first_buffet).to include('Buffet Name 2')
    expect(last_buffet).to include('Buffet Name 4')
  end


end