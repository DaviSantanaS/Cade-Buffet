require 'rails_helper'

RSpec.describe "EventTypes API", type: :request do
  context "GET /api/v1/buffets/:buffet_id/event_types" do
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
        user_id: @buffet_owner.id
      )

      @event_types = [
        @buffet.event_types.create!(
          name: 'Wedding',
          description: 'A beautiful wedding event',
          min_capacity: 50,
          max_capacity: 200,
          duration_minutes: 120,
          menu_text: 'Menu extense text',
          has_alcoholic_beverages: true,
          has_decorations: true,
          has_parking_service: true,
          venue_options: 1,
          days_of_week: "[\"0\",\"6\"]",
          buffet_id: @buffet.id),
        @buffet.event_types.create!(
          name: 'Birthday',
          description: 'Fun birthday party',
          min_capacity: 20,
          max_capacity: 100,
          duration_minutes: 90,
          menu_text: 'Menu extense text 2',
          has_alcoholic_beverages: false,
          has_decorations: true,
          has_parking_service: true,
          venue_options: 1,
          days_of_week: "[\"0\",\"6\"]",
          buffet_id: @buffet.id)
      ]
    end

    it 'returns all event types for the specified buffet' do
      get api_v1_buffet_event_types_path(buffet_id: @buffet.id)

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(json_response.length).to eq(2)
      expect(json_response[0]['name']).to eq('Wedding')
      expect(json_response[1]['name']).to eq('Birthday')
    end

    it 'returns an error when the buffet does not exist' do
      get api_v1_buffet_event_types_path(buffet_id: -1)

      expect(response).to have_http_status(404)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body)['error']).to eq('Buffet not found')
    end
  end
end
