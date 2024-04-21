require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      @buffet_owner = User.create!(
        email: 'buffet_owner@example.com',
        password: 'password',
        name: 'Buffet Owner',
        buffet_owner: true
      )


      buffet = Buffet.new(
        name: 'Test Buffet',
        company_name: 'Test Company',
        cnpj: '12345678901234',
        phone: '99-12345-6789',
        contact_email: 'test@example.com',
        address: '123 Test St',
        district: 'Test District',
        state: 'TS',
        city: 'Test City',
        zip_code: '12345678',
        user_id: @buffet_owner.id
      )
      expect(buffet).to be_valid
    end
    it 'is invalid without required attributes' do

      buffet = Buffet.new

      expect(buffet).to_not be_valid
      expect(buffet.errors[:name]).to include("can't be blank")
      expect(buffet.errors[:company_name]).to include("can't be blank")
      expect(buffet.errors[:cnpj]).to include("can't be blank")
      expect(buffet.errors[:phone]).to include("can't be blank")
      expect(buffet.errors[:contact_email]).to include("can't be blank")
      expect(buffet.errors[:address]).to include("can't be blank")
      expect(buffet.errors[:district]).to include("can't be blank")
      expect(buffet.errors[:state]).to include("can't be blank")
      expect(buffet.errors[:city]).to include("can't be blank")
      expect(buffet.errors[:zip_code]).to include("can't be blank")
    end


    it 'is invalid with invalid CNPJ format' do
      buffet = Buffet.new(cnpj: '12345') # Invalid CNPJ format
      expect(buffet).to_not be_valid
      expect(buffet.errors[:cnpj]).to include('CNPJ must be in the format 12345678901234')
    end

    it 'is invalid with invalid phone number format' do
      buffet = Buffet.new(phone: '12345678') # Invalid phone number format
      expect(buffet).to_not be_valid
      expect(buffet.errors[:phone]).to include('Phone number must be in the format XX-XXXX-XXXX')
    end

    it 'is invalid with state length exceeding maximum' do
      buffet = Buffet.new(state: 'TESTSTATELONGER') # State length exceeds maximum
      expect(buffet).to_not be_valid
      expect(buffet.errors[:state]).to include('is too long (maximum is 2 characters)')
    end

    it 'is invalid with city length exceeding maximum' do
      buffet = Buffet.new(city: 'A' * 256) # City length exceeds maximum
      expect(buffet).to_not be_valid
      expect(buffet.errors[:city]).to include('is too long (maximum is 255 characters)')
    end

    it 'is invalid with zip code length exceeding maximum' do
      buffet = Buffet.new(zip_code: '123456789') # Zip code length exceeds maximum
      expect(buffet).to_not be_valid
      expect(buffet.errors[:zip_code]).to include('is too long (maximum is 8 characters)')
    end
  end

end

