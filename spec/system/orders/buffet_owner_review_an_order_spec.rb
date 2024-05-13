require 'rails_helper'

RSpec.describe 'Buffet owner manages orders', type: :feature do
  let(:buffet_owner) { User.create!(email: 'buffet_owner@example.com', password: 'password', name: 'Buffet Owner', buffet_owner: true) }
  let(:buffet) {
    Buffet.create!(
      name: 'Buffet Name', company_name: 'Buffet Company Name', cnpj: '28934084000150',
      phone: '12-34567-8901', contact_email: 'buffet@email.com', address: 'Buffet Address',
      district: 'Buffet District', state: 'BS', city: 'Buffet City', description: 'Buffet Description',
      payment_methods: 'Buffet Payment methods', zip_code: '12345678', user: buffet_owner
    )
  }
  let(:event_type) {
    EventType.create!(
      name: 'Wedding', description: 'Wedding event type description', min_capacity: 50, max_capacity: 200,
      duration_minutes: 360, menu_text: 'Wedding menu options', has_alcoholic_beverages: true,
      has_decorations: true, has_parking_service: true, venue_options: 'Buffet venue options',
      days_of_week: '["0","6"]', buffet: buffet
    )
  }
  let!(:order) {
    Order.create!(
      user: buffet_owner, buffet: buffet, event_type: event_type, event_date: Date.tomorrow,
      guest_count: 100, details: 'Wedding details', status: 'pending'
    )
  }
  let!(:conflicting_order) {
    Order.create!(
      user: buffet_owner, buffet: buffet, event_type: event_type, event_date: Date.tomorrow,
      guest_count: 150, details: 'Another Wedding details', status: 'pending'
    )
  }

  before do
    login_as(buffet_owner, scope: :user)
    visit orders_path
  end

  # it 'displays all orders with pending orders separated' do
  #   expect(page).to have_content('Pending Orders')
  #   within('.pending-orders') do
  #     expect(page).to have_content(order.event_date.strftime("%d/%m/%Y"))
  #     expect(page).to have_content('Pending')
  #     expect(page).to have_content(order.details)
  #   end
  #
  #   expect(page).to have_content('Orders')
  #   within('.other-orders') do
  #     expect(page).not_to have_content('Pending')
  #   end
  # end
end
