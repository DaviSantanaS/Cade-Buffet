require 'rails_helper'

RSpec.describe EventPrice, type: :model do
  describe 'validations' do
    let(:buffet_owner) do
      User.create!(
        email: 'buffet_owner@example.com',
        password: 'password',
        name: 'Buffet Owner',
        buffet_owner: true
      )
    end

    let(:buffet) do
      Buffet.create!(
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
        user_id: buffet_owner.id
      )
    end

    let(:event_type) do
      EventType.create!(
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
        buffet_id: buffet.id,
        days_of_week: '[Monday,Wednesday]'
      )
    end

    it 'is valid with valid attributes' do
      event = EventPrice.new(
        event_type_id: event_type.id,
        buffet_id: buffet.id,
        base_price: 10000,
        additional_price_per_person: 500,
        extra_hour_price: 3000,
        days_of_week: '["Monday","Wednesday"]'
      )
      expect(event).to be_valid
    end

    it 'is invalid without event_type_id' do
      event = EventPrice.new(
        buffet_id: buffet.id,
        base_price: 10000,
        additional_price_per_person: 500,
        extra_hour_price: 3000,
        days_of_week: '["Monday","Wednesday"]'
      )
      expect(event).not_to be_valid
    end

    it 'is invalid without buffet_id' do
      event = EventPrice.new(
        event_type_id: event_type.id,
        base_price: 10000,
        additional_price_per_person: 500,
        extra_hour_price: 3000,
        days_of_week: '["Monday","Wednesday"]'
      )
      expect(event).not_to be_valid
    end

    it 'is invalid without base_price' do
      event = EventPrice.new(
        event_type_id: event_type.id,
        buffet_id: buffet.id,
        additional_price_per_person: 500,
        extra_hour_price: 3000,
        days_of_week: '["Monday","Wednesday"]'
      )
      expect(event).not_to be_valid
    end

    it 'is invalid without additional_price_per_person' do
      event = EventPrice.new(
        event_type_id: event_type.id,
        buffet_id: buffet.id,
        base_price: 10000,
        extra_hour_price: 3000,
        days_of_week: '["Monday","Wednesday"]'
      )
      expect(event).not_to be_valid
    end

    it 'is invalid without extra_hour_price' do
      event = EventPrice.new(
        event_type_id: event_type.id,
        buffet_id: buffet.id,
        base_price: 10000,
        additional_price_per_person: 500,
        days_of_week: '["Monday","Wednesday"]'
      )
      expect(event).not_to be_valid
    end

    it 'is valid with valid attributes including days_of_week' do
      event = EventPrice.new(
        event_type_id: event_type.id,
        buffet_id: buffet.id,
        base_price: 10000,
        additional_price_per_person: 500,
        extra_hour_price: 3000,
        days_of_week: '["Monday","Wednesday"]'
      )
      expect(event).to be_valid
    end

    it 'is invalid without days_of_week' do
      event = EventPrice.new(
        event_type_id: event_type.id,
        buffet_id: buffet.id,
        base_price: 10000,
        additional_price_per_person: 500,
        extra_hour_price: 3000
      )
      expect(event).not_to be_valid
      expect(event.errors[:days_of_week]).to include("can't be blank")
    end

    it 'checks uniqueness of days_of_week scoped to event_type_id and buffet_id' do
      existing_event = EventPrice.create!(
        event_type_id: event_type.id,
        buffet_id: buffet.id,
        base_price: 20000,
        additional_price_per_person: 1000,
        extra_hour_price: 2000,
        days_of_week: '["Monday","Wednesday"]'
      )

      new_event = EventPrice.new(
        event_type_id: event_type.id,
        buffet_id: buffet.id,
        base_price: 15000,
        additional_price_per_person: 750,
        extra_hour_price: 1500,
        days_of_week: '["Monday","Wednesday"]'
      )

      expect(new_event).not_to be_valid
      expect(new_event.errors[:days_of_week]).to include("has overlapping days with other prices")
    end
  end
end
