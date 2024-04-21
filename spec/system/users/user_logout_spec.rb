require 'rails_helper'

describe 'User logout' do
  before do
    @buffet_owner = User.create!(
      email: 'buffet_owner@example.com',
      password: 'password',
      name: 'Buffet Owner',
      buffet_owner: true
    )

    login_as @buffet_owner, scope: :user
    visit root_path

  end

  it 'successfully' do
    click_on 'Logout'

    expect(page).to have_content('Signed out successfully.')
    expect(page).to have_link('Login')
  end
end
