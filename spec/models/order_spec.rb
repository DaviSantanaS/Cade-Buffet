require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:buffet_owner) { User.create!(email: 'buffet_owner@example.com', password: 'password', name: 'Buffet Owner', buffet_owner: true) }
  let(:buffet) {
    Buffet.create!(
      name: 'Buffet Name', company_name: 'Buffet Company Name', cnpj: '28934084000150', phone: '12-34567-8901',
      contact_email: 'buffet@email.com', address: 'Buffet Address', district: 'Buffet District',
      state: 'BS', city: 'Buffet City', description: 'Buffet Description',
      payment_methods: 'Buffet Payment methods', zip_code: '12345678', user: buffet_owner
    )
  }
  let(:event_type) {
    EventType.create!(
      name: 'Event Type Name', description: 'Event Type Description', min_capacity: 10, max_capacity: 100,
      duration_minutes: 60, menu_text: 'Event Type Menu', has_alcoholic_beverages: true,
      has_decorations: false, has_parking_service: true, venue_options: "Client's Address",
      days_of_week: '["0","6"]', buffet: buffet
    )
  }
  let(:order) {
    Order.new(
      user: buffet_owner, buffet: buffet, event_type: event_type,
      event_date: Date.tomorrow, guest_count: 50, details: 'Birthday party'
    )
  }

  describe 'Validations' do
    it 'is valid with all required attributes' do
      expect(order).to be_valid
    end

    it 'is invalid without an event date' do
      order.event_date = nil
      expect(order).not_to be_valid
      expect(order.errors[:event_date]).to include("can't be blank")
    end

    it 'is invalid without guest count' do
      order.guest_count = nil
      expect(order).not_to be_valid
      expect(order.errors[:guest_count]).to include("can't be blank")
    end

    it 'is invalid without details' do
      order.details = nil
      expect(order).not_to be_valid
      expect(order.errors[:details]).to include("can't be blank")
    end

    it 'does not allow guest count to exceed event type max capacity' do
      order.guest_count = 150
      expect(order).not_to be_valid
      expect(order.errors[:guest_count]).to include("exceeds the maximum capacity of 100 guests")
    end

    it 'prevents booking in the past' do
      order.event_date = Date.yesterday
      expect(order).not_to be_valid
      expect(order.errors[:event_date]).to include("can't be in the past")
    end
  end

  describe 'Callbacks' do
    let(:new_order) {
      Order.create(
        user: buffet_owner, buffet: buffet, event_type: event_type,
        event_date: Date.tomorrow, guest_count: 20, details: 'Small party'
      )
    }

    it 'generates a unique code on create' do
      expect(new_order.code).not_to be_nil
      expect(new_order.code.length).to eq(8)
    end

    it 'sets default status to pending on create' do
      expect(new_order.status).to eq('pending')
    end
  end
end
