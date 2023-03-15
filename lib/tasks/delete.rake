namespace :post do
  desc 'delete posts'

  task delete: :environment do
    Post.destroy_all
    puts 'post delete successfully!'
  end
end
