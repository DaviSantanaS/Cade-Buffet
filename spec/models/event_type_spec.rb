require 'rails_helper'

RSpec.describe EventType, type: :model do
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

  subject(:event_type) do
    described_class.new(
      name: 'Event Type Name',
      description: 'Event Type Description',
      min_capacity: 10,
      max_capacity: 100,
      duration_minutes: 60,
      menu_text: 'Event Type Menu',
      has_alcoholic_beverages: true,
      has_decorations: false,
      has_parking_service: true,
      venue_options: 'Event Type Venue Options',
      buffet: buffet
    )
  end

  it 'is valid with valid attributes' do
    expect(event_type).to be_valid
  end

  it 'is not valid without a name' do
    event_type.name = nil
    expect(event_type).not_to be_valid
  end

  it 'is not valid without a description' do
    event_type.description = nil
    expect(event_type).not_to be_valid
  end

  it 'is not valid with min_capacity less than 0' do
    event_type.min_capacity = -10
    expect(event_type).not_to be_valid
  end

  it 'is not valid with max_capacity less than min_capacity' do
    event_type.max_capacity = 5
    expect(event_type).not_to be_valid
  end

  it 'is not valid with duration_minutes less than or equal to 0' do
    event_type.duration_minutes = 0
    expect(event_type).not_to be_valid
  end

  it 'is associated with a buffet' do
    expect(event_type.buffet).to eq(buffet)
  end
end
