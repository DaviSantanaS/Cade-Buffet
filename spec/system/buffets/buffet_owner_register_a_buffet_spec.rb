require 'rails_helper'

describe 'Buffet owner register a buffet' do

  it 'successfully' do

    @buffet_owner = User.create!(
      email: 'buffet_owner@example.com',
      password: 'password',
      name: 'Buffet Owner',
      buffet_owner: true
    )

    login_as @buffet_owner, scope: :user
    visit root_path


    fill_in 'Name', with: 'Buffet Name'
    fill_in 'Company Name', with: 'Buffet Company Name'
    fill_in 'CNPJ', with: '22202911000134'
    fill_in 'Phone', with: '12-34567-8901'
    fill_in 'Contact Email', with: 'contact@email.com'
    fill_in 'Address', with: 'Buffet Address'
    fill_in 'District', with: 'Buffet District'
    fill_in 'State', with: 'BS'
    fill_in 'City', with: 'Buffet City'
    fill_in 'ZIP Code', with: '12345678'
    fill_in 'Description', with: 'Buffet Description'
    fill_in 'Payment Methods', with: 'Buffet Payment methods'


    click_on 'Create Buffet'

    expect(page).to have_content('Buffet Name')
    expect(page).to have_content('Buffet Company Name')
    expect(page).to have_content('22202911000134')
    expect(page).to have_content('12-34567-8901')
    expect(page).to have_content('No event types offered yet.')

  end

end