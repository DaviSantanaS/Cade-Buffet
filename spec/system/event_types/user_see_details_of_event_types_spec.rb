require 'rails_helper'

describe 'User see details of event types' do
  before do

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
      user_id: @buffet_owner.id)

    @event_type = EventType.create!(
      name: 'Event Type Name',
      description: 'Event Type Description',
      min_capacity: 10,
      max_capacity: 100,
      duration_minutes: 60,
      menu_text: 'Event Type Menu',
      has_alcoholic_beverages: true,
      has_decorations: false,
      has_parking_service: true,
      venue_options: "Client's Address",
      days_of_week: "[\"0\",\"6\"]",
      buffet: @buffet
    )

    @event_type_2 = EventType.create!(
      name: 'Wedding',
      description: 'A beautiful wedding celebration',
      min_capacity: 50,
      max_capacity: 200,
      duration_minutes: 240,
      menu_text: 'Exquisite wedding menu with various options',
      has_alcoholic_beverages: true,
      has_decorations: true,
      has_parking_service: true,
      venue_options: "Buffet's Venue",
      days_of_week: "[\"1\",\"2\",\"3\",\"4\",\"5\"]",
      buffet: @buffet
    )

    @event_price = EventPrice.create!(
      base_price: 1000,
      additional_price_per_person: 100,
      extra_hour_price: 500,
      event_type: @event_type,
      buffet: @buffet,
      days_of_week: "[\"0\",\"6\"]",
    )


  end

  it 'as buffet owner' do
    login_as @buffet_owner, scope: :user
    visit root_path
    click_on 'Buffet Name'
    click_on 'Event Type Name'

    expect(page).to have_content('Event Type Name')
    expect(page).to have_content('Event Type Description')
    expect(page).to have_content('10')
    expect(page).to have_content('100')
    expect(page).to have_content('60')
    expect(page).to have_content('Event Type Menu')
    expect(page).to have_content('Yes')
    expect(page).to have_content('No')
    expect(page).to have_content('Yes')
    expect(page).to have_content("Client's Address")
    expect(page).to have_link('Add Event Price')
  end

  it 'as a user' do
    visit root_path
    click_on 'Buffet Name'


    expect(page).to have_content('Event Type Name')
    expect(page).to have_content('Event Type Description')
    expect(page).to have_content('Event Type Menu')
    expect(page).to have_content('Base Price: $1,000.00')
    expect(page).to have_content('Additional Price per Person: $100.00')
    expect(page).to have_content('Extra Hour Price: $500.00')

  end

end