require 'rails_helper'

describe 'buffet owner create event type' do
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
      cnpj: '20516752000117',
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
    click_on 'New event type'
    fill_in 'Name', with: 'Event Type Name'
    fill_in 'Description', with: 'Event Type Description'
    fill_in 'Min capacity', with: '10'
    fill_in 'Max capacity', with: '100'
    fill_in 'Duration minutes', with: '120'
    fill_in 'Menu text', with: 'Menu extense text'
    check 'Has alcoholic beverages'
    check 'Has decorations'
    check 'Has parking service'
    check 'Monday'
    check 'Sunday'



    select "Client's Address", from: 'Venue options'


    click_on 'Create Event type'

    expect(current_path).to eq(buffet_path(@buffet.id))
    expect(page).to have_content('Buffet Details')
    expect(page).to have_content('Event Type Name')
    expect(page).to have_content('Event Type Description')
    expect(page).not_to have_content('No event types offered yet.')
  end


end