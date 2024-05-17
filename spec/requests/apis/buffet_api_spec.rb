require 'rails_helper'

RSpec.describe "Buffets API", type: :request do
  context "GET /api/v1/buffets/:id" do
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

      buffet_owner2 = User.create!(
        email: 'buffet_owner2@example.com',
        password: 'password',
        name: 'Buffet Owner 2',
        buffet_owner: true
      )

      buffet2 = Buffet.create!(
        name: 'Buffet Name 2',
        company_name: 'Buffet Company Name 2',
        cnpj: '35306967000180',
        phone: '12-34567-8902',
        contact_email: 'buffet2@email.com',
        address: 'Buffet Address 2',
        district: 'Buffet District 2',
        state: 'BS',
        city: 'Buffet City 2',
        description: 'Buffet Description 2',
        payment_methods: 'Buffet Payment methods 2',
        zip_code: '12345679',
        user_id: buffet_owner2.id
      )

      buffet_owner3 = User.create!(
        email: 'buffet_owner3@example.com',
        password: 'password',
        name: 'Buffet Owner 3',
        buffet_owner: true
      )

      buffet3 = Buffet.create!(
        name: 'Buffet Name 3',
        company_name: 'Buffet Company Name 3',
        cnpj: '41864181000181',
        phone: '12-34567-8903',
        contact_email: 'buffet3@email.com',
        address: 'Buffet Address 3',
        district: 'Buffet District 3',
        state: 'BS',
        city: 'Buffet City 3',
        description: 'Buffet Description 3',
        payment_methods: 'Buffet Payment methods 3',
        zip_code: '12345680',
        user_id: buffet_owner3.id
      )
    end

    it 'returns buffet details successfully' do
      get api_v1_buffet_path(@buffet.id,  locale: :en)

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(json_response['name']).to eq('Buffet Name')
      expect(json_response['description']).to eq('Buffet Description')
      expect(json_response['phone']).to eq('12-34567-8901')
      expect(json_response['contact_email']).to eq('buffet@email.com')
      expect(json_response['address']).to eq('Buffet Address')
      expect(json_response['district']).to eq('Buffet District')
      expect(json_response['state']).to eq('BS')
      expect(json_response['payment_methods']).to eq('Buffet Payment methods')
      expect(json_response).not_to have_key('cnpj')
      expect(json_response).not_to have_key('company_name')
    end

    it 'returns a list of buffets' do
      get api_v1_buffets_path

      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      expect(json_response.size).to eq(3)
      expect(json_response[0]['name']).to eq('Buffet Name')
      expect(json_response[1]['name']).to eq('Buffet Name 2')
      expect(json_response[2]['name']).to eq('Buffet Name 3')

    end

    it 'returns an error for a non-existent buffet' do
      get api_v1_buffet_path(-1, locale: :en)

      expect(response).to have_http_status(404)
      expect(response.content_type).to include('application/json')
      expect(JSON.parse(response.body)['error']).to eq('Buffet not found')
    end
  end
end
