require 'rails_helper'

RSpec.describe "EventTypes API", type: :request do
  context "POST /api/v1/buffets/:buffet_id/event_types/:id/check_availability" do
    let(:buffet_owner) {
      User.create!(
        email: 'buffet_owner@example.com',
        password: 'password',
        name: 'Buffet Owner',
        buffet_owner: true)
    }

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

    let(:event_price) {
      EventPrice.create!(
        event_type_id: event_type.id,
        buffet_id: buffet.id,
        base_price: 7000,
        additional_price_per_person: 70,
        extra_hour_price: 500,
        days_of_week: "[\"0\",\"6\"]"
      )
    }

    let(:next_sunday) { Date.today.next_occurring(:sunday) }
    let(:next_tuesday) { Date.today.next_occurring(:tuesday) }

    # it 'returns availability and estimated price when the event is available' do
    #   post check_availability_api_v1_buffet_event_type_path(
    #          buffet_id: buffet.id, id: event_type.id),
    #        params: { event_date: next_sunday, guest_count: 100 }
    #
    #   json_response = JSON.parse(response.body)
    #
    #   expect(response).to have_http_status(200)
    #   expect(response.content_type).to include('application/json')
    #   expect(json_response['available']).to eq(true)
    #   expect(json_response['estimated_price']).to eq(3500)
    # end

    it 'returns an error when the event type is not available on the specified date' do
      post check_availability_api_v1_buffet_event_type_path(
             buffet_id: buffet.id, id: event_type.id),
           params: { event_date: next_tuesday, guest_count: 100 }

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(422)
      expect(response.content_type).to include('application/json')
      expect(json_response['available']).to eq(false)
      expect(json_response['error']).to eq('Event type not available on this day of the week')
    end

    it 'returns an error when no price is set for the specified day' do
      event_price.destroy

      post check_availability_api_v1_buffet_event_type_path(
             buffet_id: buffet.id, id: event_type.id),
           params: { event_date: next_sunday, guest_count: 100 }

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(422)
      expect(response.content_type).to include('application/json')
      expect(json_response['available']).to eq(false)
      expect(json_response['error']).to eq('No price set for this day')
    end

    it 'returns an error when the guest count is outside the allowed range' do
      post check_availability_api_v1_buffet_event_type_path(
             buffet_id: buffet.id, id: event_type.id),
           params: { event_date: next_sunday, guest_count: 1000 }

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(422)
      expect(response.content_type).to include('application/json')
      expect(json_response['available']).to eq(false)
      expect(json_response['error']).to eq('Event type not available on this date for the specified guest count')
    end
  end
end