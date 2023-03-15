namespace :user_create do
  desc "user create"

  task create: :environment do
    10.times do
      User.create!([{
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: '123456',
          password_confirmation: '123456',
          phone: '09987654321',
          address: Faker::Address.full_address,
          birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
          role: rand(0..1) == 1 ? 'user' : 'admin'
      }])
    end
    puts "#{User.count} create successfully!"
  end
end
