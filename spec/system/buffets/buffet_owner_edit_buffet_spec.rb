require 'rails_helper'

describe 'buffet owner edit buffet' do
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
      user_id: @buffet_owner.id)


    login_as @buffet_owner, scope: :user
    visit root_path
  end

  it 'sucessfully' do
    click_on 'Buffet Name'
    click_on 'Edit Buffet'
    fill_in 'Name', with: 'Buffet Name Edited'
    click_on 'Save Buffet'

    expect(page).to have_content('Buffet Details')
    expect(page).to have_content('Buffet Name Edited')
  end

  it 'and go back without saving' do
    click_on 'Buffet Name'
    click_on 'Edit Buffet'
    fill_in 'Name', with: 'Buffet Name Edited'
    click_on 'Back'


    expect(page).to have_content('Buffet Details')
    expect(page).to have_content('Buffet Name')
  end
end