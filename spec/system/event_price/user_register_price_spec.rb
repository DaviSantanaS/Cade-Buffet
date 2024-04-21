require 'rails_helper'

describe 'User register price' do
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
      name: 'Event Type Name',
      description: 'Event Type Description',
      min_capacity: 10,
      max_capacity: 100,
      duration_minutes: 120,
      menu_text: 'Menu extense text',
      has_alcoholic_beverages: true,
      has_decorations: true,
      has_parking_service: true,
      venue_options: 1,
      buffet_id: @buffet.id
    )

    login_as @buffet_owner, scope: :user

  end


  it 'sucessfully' do

    click_on 'Buffet Name'
    click_on 'Event_type_name'
    click_on 'Register Price'

    fill_in 'Base price', with: '1000'
    fill_in 'Additional price per person', with: 50
    fill_in 'Extra hour price', with: 300
    click_on 'Create Price'

    expect(page).to have_content('Event Type Name')
    expect(page).to have_content('Base price: $ 1.000,00')


  end

end