require 'rails_helper'

describe 'user makes a  order' do
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
      user_id: @buffet_owner.id
    )

    @event_type = EventType.create!(
      name: 'Wedding',
      description: 'Wedding event type description',
      min_capacity: 50,
      max_capacity: 200,
      duration_minutes: 360,
      menu_text: 'Wedding menu options',
      has_alcoholic_beverages: true,
      has_decorations: true,
      has_parking_service: true,
      venue_options: 'Buffet venue options',
      buffet_id: @buffet.id
    )

    @regular_user = User.create!(
      email: 'regular_user@example.com',
      password: 'password',
      name: 'Regular User',
      cpf: '52998224725',
      buffet_owner: false
    )

    login_as @regular_user, scope: :user
  end

  it 'successfully' do
    visit root_path
    click_on 'Buffet Name'
    click_on 'Make Order'

    select 'Wedding', from: 'Event Type'
    fill_in 'Event Date', with: '2024-05-15'
    fill_in 'Number of Guests', with: 100
    fill_in 'Event Details', with: 'Wedding details'

    click_on 'Create Order'

    expect(page).to have_content('Order Details')
    expect(page).to have_content('Wedding')
    expect(page).to have_content('2024-05-15')
    expect(page).to have_content('100')
    expect(page).to have_content('Wedding details')
    expect(page).to have_content('pending')
  end

end
