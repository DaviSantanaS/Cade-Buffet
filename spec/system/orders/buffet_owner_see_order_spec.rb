require 'rails_helper'

describe 'buffet owner see an order' do

  it 'successfully' do
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')

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
      days_of_week: "[\"0\",\"6\"]",
      buffet_id: @buffet.id
    )

    @event_price = EventPrice.create!(
      base_price: 1000,
      additional_price_per_person: 100,
      extra_hour_price: 500,
      event_type: @event_type,
      buffet: @buffet,
      days_of_week: "[\"0\",\"6\"]",
      )

    @regular_user = User.create!(
      email: 'regular_user@example.com',
      password: 'password',
      name: 'Regular User',
      cpf: '52998224725',
      buffet_owner: false
    )

    @order = Order.create!(
      event_date: '2024-05-15',
      guest_count: 100,
      user_id: @regular_user.id,
      event_type_id: @event_type.id,
      buffet_id: @buffet.id,
      details: 'Order Details',
      alternative_address: 'Alternative Address'
    )



    login_as @buffet_owner, scope: :user

    visit root_path
    within("nav")do
      click_on 'Orders'
    end

    expect(page).to have_content('Pending')
    expect(page).to have_content('#ABC12345')

  end

end