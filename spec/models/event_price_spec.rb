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
        buffet_id: buffet.id
      )
    end

    it 'is valid with valid attributes' do
      event = EventPrice.new(
        event_type_id: event_type.id,
        buffet_id: buffet.id,
        base_price: 10000,
        additional_price_per_person: 500,
        extra_hour_price: 3000
      )
      expect(event).to be_valid
    end

    it 'is invalid without event_type_id' do
      event = EventPrice.new(
        buffet_id: buffet.id,
        base_price: 10000,
        additional_price_per_person: 500,
        extra_hour_price: 3000
      )
      expect(event).not_to be_valid
    end

    it 'is invalid without buffet_id' do
      event = EventPrice.new(
        event_type_id: event_type.id,
        base_price: 10000,
        additional_price_per_person: 500,
        extra_hour_price: 3000
      )
      expect(event).not_to be_valid
    end

    it 'is invalid without base_price' do
      event = EventPrice.new(
        event_type_id: event_type.id,
        buffet_id: buffet.id,
        additional_price_per_person: 500,
        extra_hour_price: 3000
      )
      expect(event).not_to be_valid
    end

    it 'is invalid without additional_price_per_person' do
      event = EventPrice.new(
        event_type_id: event_type.id,
        buffet_id: buffet.id,
        base_price: 10000,
        extra_hour_price: 3000
      )
      expect(event).not_to be_valid
    end

    it 'is invalid without extra_hour_price' do
      event = EventPrice.new(
        event_type_id: event_type.id,
        buffet_id: buffet.id,
        base_price: 10000,
        additional_price_per_person: 500
      )
      expect(event).not_to be_valid
    end
  end
end
