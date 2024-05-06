# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Criação de usuários (donos de buffet e clientes)
users = User.create([ {email: 'davi@gmail', password: '123456',
                       name: 'Davi', buffet_owner: true},
                      { email: 'owner1@buffet.com', password: '123456',
                        name: 'Owner One', buffet_owner: true },
                      { email: 'owner2@buffet.com', password: '123456',
                        name: 'Owner Two', buffet_owner: true },
                      { email: 'owner3@buffet.com', password: '123456',
                        name: 'Owner Three', buffet_owner: true },
                      { email: 'client1@client.com', password: '123456',
                        name: 'Client One', cpf: "084.229.090-73",buffet_owner: false },
                      { email: 'client2@client.com', password: '123456',
                        name: 'Client Two', cpf: "381.224.840-93",buffet_owner: false },
                      { email: 'client3@client.com', password: '123456',
                        name: 'Client Three', cpf: "759.546.500-12", buffet_owner: false },
                      { email: 'cliente@gmail', password: '123456',
                        name: 'cliente', cpf: '354.282.820-37', buffet_owner: false }
                    ])

# Criação de buffets
buffets = Buffet.create([
                          { name: "Dave's Elegant Events", company_name: "Green Garden Buffet",
                            cnpj: "58.484.017/0001-41", phone: "21-12345-1234", contact_email: "davescompany@email",
                            address: "Avenida das Palmeiras, 580", district: "Jardim das Flores", state: "SP",
                            city: "São Paulo", zip_code: "12345000",
                            description: "Dave's Buffet oferece serviços completos de catering e organização de
                              eventos, especializado em casamentos, formaturas e eventos corporativos, com menus
                              personalizados e decoração de alta qualidade",
                            payment_methods: "Cartão, PIX", user_id: users[0].id },

                          { name: "Green Garden Events", company_name: "Green Garden Buffet",
                            cnpj: "04.552.218/0001-00", phone: "11-98756-5432", contact_email: "info@greengarden.com",
                            address: "Rua dos Coqueiros, 102", district: "Vila Mariana", state: "SP", city: "São Paulo",
                            zip_code: "12345000", description: "Espaço ao ar livre para eventos.",
                            payment_methods: "Cartão, PIX", user_id: users[1].id },

                          { name: "Urban Chic Hall", company_name: "Urban Chic Buffet", cnpj: "20.384.235/0001-31",
                            phone: "12-99988-9776", contact_email: "contact@urbanchic.com",
                            address: "Avenida dos Lírios, 456", district: "Bosque das Orquídeas", state: "SP",
                            city: "Campinas", zip_code: "12456000", description: "Local moderno para eventos.",
                            payment_methods: "Cartão, Boleto", user_id: users[2].id },

                          { name: "Lakeside Retreat", company_name: "Lakeside Buffet", cnpj: "21.735.741/0001-90",
                            phone: "13-11223-3344", contact_email: "lakeside@retreat.com", address: "Orla do Lago, 789",
                            district: "Lagoa Azul", state: "SP", city: "Santos", zip_code: "13579000",
                            description: "Refúgio à beira do lago.", payment_methods: "Cartão, Transferência",
                            user_id: users[3].id }
                        ])

buffets.each do |buffet|
  3.times do |i|
    event_type = EventType.create({
                                    name: "Tipo #{i+1} - #{buffet.name}",
                                    description: "Descrição do evento tipo #{i+1}",
                                    min_capacity: 20 * (i + 1),
                                    max_capacity: 50 * (i + 1),
                                    duration_minutes: 180 + (60 * i),
                                    menu_text: "Menu para evento tipo #{i+1}",
                                    has_alcoholic_beverages: [true, false].sample,
                                    has_decorations: [true, false].sample,
                                    has_parking_service: [true, false].sample,
                                    days_of_week: "[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"0\"]",
                                    buffet_id: buffet.id
                                  })

    EventPrice.create({
                        event_type_id: event_type.id,
                        buffet_id: buffet.id,
                        base_price: 5000 + (1000 * i),
                        additional_price_per_person: 50 + (10 * i),
                        extra_hour_price: 300 + (50 * i),
                        days_of_week: "[\"1\",\"2\",\"3\",\"4\",\"5\"]"
                      })

    EventPrice.create({
                        event_type_id: event_type.id,
                        buffet_id: buffet.id,
                        base_price: 7000 + (1000 * i),
                        additional_price_per_person: 70 + (10 * i),
                        extra_hour_price: 500 + (50 * i),
                        days_of_week: "[\"0\",\"6\"]"
                      })
  end
end
