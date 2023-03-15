namespace :post do
  desc "post create"

  task create: :environment do
    10.times do
      Post.create!([{
        title: Faker::Lorem.words(number: rand(2..10)).join(' '),
        description: Faker::Lorem.paragraphs.join(' '),
        privacy: rand(0..1) == 1 ? 'private' : 'public',
        user_id: rand(1..3)
      }])
    end
    puts "#{Post.count} create successfully!"
  end
end
