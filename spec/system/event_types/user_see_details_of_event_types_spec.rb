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
      cnpj: '12345678000190',
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
      buffet: @buffet)
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
    expect(page).to have_link('Register Price')
  end

end