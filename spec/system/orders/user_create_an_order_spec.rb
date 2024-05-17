require 'rails_helper'

RSpec.describe 'User makes an order', type: :feature do
  let!(:buffet_owner) {
    User.create!(
      email: 'buffet_owner@example.com',
      password: 'password',
      name: 'Buffet Owner',
      buffet_owner: true) }
  let!(:buffet) {
    Buffet.create!(
      name: 'Buffet Name',
      company_name: 'Buffet Company Name',
      cnpj: '28934084000150',
      phone: '12-34567-8901',
      contact_email: 'buffet@email.com',
      address: 'Buffet Address',
      district: 'Buffet District',
      state: 'BS', city: 'Buffet City',
      description: 'Buffet Description',
      payment_methods: 'Buffet Payment methods',
      zip_code: '12345678', user: buffet_owner
    )
  }
  let!(:event_type) {
    EventType.create!(
      name: 'Wedding',
      description: 'Wedding event type description',
      min_capacity: 50, max_capacity: 200,
      duration_minutes: 360,
      menu_text: 'Wedding menu options',
      has_alcoholic_beverages: true,
      has_decorations: true,
      has_parking_service: true,
      venue_options: 'Buffet venue options',
      days_of_week: "[\"0\",\"6\"]", buffet: buffet
    )
  }
  let!(:event_price) {
    EventPrice.create!(
      base_price: 1000, additional_price_per_person: 100, extra_hour_price: 500,
      event_type: event_type, buffet: buffet, days_of_week: "[\"0\",\"6\"]"
    )
  }
  let!(:regular_user) { User.create!(email: 'regular_user@example.com', password: 'password', name: 'Regular User', cpf: '52998224725', buffet_owner: false) }

  before do
    login_as regular_user, scope: :user
  end

  it 'successfully creates an order' do
    visit root_path
    click_on 'Buffet Name'
    click_on 'Make Order'

    select 'Wedding', from: 'Event Type'
    fill_in 'Event Date', with: Date.today + 7 - Date.today.wday + 1
    fill_in 'Number of Guests', with: 100
    fill_in 'Event Details', with: 'Wedding details'

    click_on 'Create Order'

    date = Date.today + 7 - Date.today.wday + 1
    expect(page).to have_content('Order Details')
    expect(page).to have_content('Wedding')
    expect(page).to have_content(date.strftime("%B %d, %Y"))
    expect(page).to have_content('100')
    expect(page).to have_content('Wedding details')
    expect(page).to have_content('pending')
  end

  it 'displays the order in the orders list with a generated order number' do
    allow(SecureRandom).to receive(:alphanumeric).and_return('ABC12345')

    visit root_path
    click_on 'Buffet Name'
    click_on 'Make Order'
    select 'Wedding', from: 'Event Type'
    fill_in 'Event Date', with: date = Date.today + 7 - Date.today.wday + 1
    fill_in 'Number of Guests', with: 100
    fill_in 'Event Details', with: 'Wedding details'
    click_on 'Create Order'
    click_on 'Orders'


    expect(page).to have_content('Order #ABC12345')
  end

  context 'when required fields are missing' do
    it 'fails to create an order' do
      visit root_path
      click_on 'Buffet Name'
      click_on 'Make Order'

      select 'Wedding', from: 'Event Type'

      click_on 'Create Order'

      expect(page).to have_content('error')
      expect(page).to have_content("Event date can't be blank")
      expect(page).to have_content("Guest count can't be blank")
      expect(page).to have_content("Details can't be blank")
    end
  end
end
