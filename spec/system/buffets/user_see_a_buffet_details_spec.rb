require 'rails_helper'

describe 'user see a buffet details' do
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

    @regular_user = User.create!(
      email: 'regular_user@example.com',
      password: 'password',
      name: 'Regular User',
      cpf: '52998224725',
      buffet_owner: false
    )

  end


  it 'sucessfully as a user' do

    login_as @regular_user, scope: :user
    visit root_path
    click_on 'Buffet Name'

    expect(page).to have_content('Buffet Details')
    expect(page).to have_content('Buffet Name')
    expect(page).not_to have_content('Buffet Company Name')
    expect(page).not_to have_content('22202911000134')
    expect(page).to have_content('12-34567-8901')
  end

  it 'sucessfully as a buffet owner' do

      login_as @buffet_owner, scope: :user
      visit root_path
      click_on 'Buffet Name'

      expect(page).to have_content('Buffet Details')
      expect(page).to have_content('Buffet Name')
      expect(page).to have_content('Buffet Company Name')
      expect(page).to have_content('22202911000134')
      expect(page).to have_content('12-34567-8901')
  end

  it 'sucessfully as a visitor' do
    visit root_path
    click_on 'Buffet Name'

    expect(page).to have_content('Buffet Details')
    expect(page).to have_content('Buffet Name')
  end

end