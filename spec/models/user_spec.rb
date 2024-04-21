require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'presence' do
    it 'false when name is empty' do
      user = User.new(
        name: '',
        email: 'test@gmail.com',
        password: '123456',
        buffet_owner: true
      )
      expect(user.valid?).to eq(false)
    end

    it 'false when buffet_owner is empty' do
      user = User.new(
        name: 'Test',
        email: 'test@gmail.com',
        password: '123456',
        buffet_owner: nil
      )
      expect(user.valid?).to eq(false)
    end
  end


end
