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
                password: '123456',
                password_confirmation: '123456',
                phone: '09987654321',
                address: 'Pyay',
                birthday: '2023-2-27',
                role: 'admin'
              }])
User.create!([{
                name: 'Ma Ma',
                email: 'mama@gmail.com',
                password: '123456',
                password_confirmation: '123456',
                phone: '09987654321',
                address: 'Pyay',
                birthday: '2023-2-27',
                role: 'user'
              }])
User.create!([{
                name: 'Ko Ko',
                email: 'koko@gmail.com',
                password: '123456',
                password_confirmation: '123456',
                phone: '09987654321',
                address: 'Pyay',
                birthday: '2023-2-27',
                role: 'user'
              }])
p "Created #{User.count} users"

Post.destroy_all
Post.create!([{
  title: Faker::Lorem.words(number: rand(2..10)).join(' '),
  description: Faker::Lorem.paragraphs.join(' '),
  privacy: rand(0..1) == 1 ? 'private' : 'public',
  user_id: rand(1..3)
}])
p "Created #{Post.count} posts"
