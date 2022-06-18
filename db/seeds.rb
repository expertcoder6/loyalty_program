# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(email: "admin@yopmail.com",password: "123456",password_confirmation: "123456",is_admin: true,birthday: Time.now)
User.create(email: "user@yopmail.com",password: "123456",password_confirmation: "123456",is_admin: false,birthday: Time.now)

store1 = Store.create(name: "Amazon",admin_id: user.id,country_type: "National")
store1.products.create(name: "Puma Shoes",price: 100,currency_type: "Dollar")
store1.products.create(name: "Necklace",price: 2000,currency_type: "Dollar")
store1.products.create(name: "Sandals",price: 1000,currency_type: "Dollar")


store2 = Store.create(name: "Flipcart",admin_id: user.id,country_type: "International")
store2.products.create(name: "Puma Shoes",price: 200,currency_type: "Rupee")
store2.products.create(name: "Necklace",price: 2000,currency_type: "Rupee")
store2.products.create(name: "Sandals",price: 1000,currency_type: "Rupee")


Reward.create(name: "Free Coffee Reward",admin_id: user.id,value: 100)
Reward.create(name: "5% Cash Rebate Reward",admin_id: user.id,value: 100)
Reward.create(name: "Free Movie Tickets",admin_id: user.id,value: 100)
Reward.create(name: "4x Airport Lounge Access Reward",admin_id: user.id,value: 100)