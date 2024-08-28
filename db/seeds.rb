# frozen_string_literal: true

require 'faker'

ActiveRecord::Base.transaction do
  user = User.create!(first_name: 'John', last_name: 'Doe')

  items = Array.new(10) do
    Item.create!(
      name: Faker::Coffee.blend_name,
      description: Faker::Coffee.notes,
      price: rand(1.0..100.0),
      stock_count: rand(1..100)
    )
  end

  addresses = Array.new(10) do
    Address.create!(
      country: Faker::Address.country,
      street: Faker::Address.street_name,
      city: Faker::Address.city,
      region: Faker::Address.state,
      building: Faker::Address.building_number
    )
  end

  clients = Array.new(9) do |i|
    Client.create!(
      nickname: Faker::Name.first_name,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      address: addresses[i],
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number
    )
  end

  supplier = Supplier.create!(
    name: Faker::Company.name,
    address: addresses.last,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number
  )

  supplier_order = SupplierOrder.create!(user:, supplier:)
  OrderItem.create!(order: supplier_order, item: items[0], count: 10)

  30.times do |i|
    itms = items.dup.shuffle
    client = clients.sample
    order = ClientOrder.create!(
      user:, client:,
      phone: client.phone,
      country: client.address.country,
      city: client.address.city,
      region: client.address.region,
      street: client.address.street,
      building: client.address.building
    )
    rand(1..5).times do
      OrderItem.create!(order:, item: itms.pop, count: rand(1..10))
    end

    puts "Order #{i + 1} created"
  end
end
