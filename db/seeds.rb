# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
User.create!([{
                name: 'Admin',
                email: 'admin@gmail.com',
                password: '12345',
                password_confirmation: '12345',
                phone: '09987654321',
                address: 'Pyay',
                birthday: '2023-2-27',
                role: 'admin'
              }])
p "Created #{User.count} users"

Post.destroy_all
Post.create!([{
  title: 'Routing In Ruby On Rails',
  description: 'The Router is responsible for matching the incoming HTTP request to the appropriate controller action to run, based on the HTTP verb and the URL being requested. It is a critical part of any Rails application as it determines what response the user will receive.

  When an HTTP request arrives, Rails also grabs all the parameters that came with it and makes them available in a special hash called params. This hash can be…
  
  ',
  privacy: 'public'
}])
p "Created #{Post.count} posts"
